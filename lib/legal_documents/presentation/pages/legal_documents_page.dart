import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:toast/toast.dart';

import '../../../Global/Variables/colors.dart';
import '../../../Global/Widgets/app_drawer.dart';
import '../../../Global/Widgets/error_widget.dart';
import '../../../Global/Widgets/loading_widget.dart';
import '../../../Global/Widgets/not_found_widget.dart';
import '../bloc/legal_documents_page/legal_documents_page_bloc.dart';
import '../forms/documents_form.dart';
import '../widget/legal_document_success_widget.dart';
import '../widget/no_documents_widget.dart';

class LegalDocumentsPage extends StatelessWidget {
  const LegalDocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Documents"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.lighterColor,
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(FeatherIcons.plus),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            enableDrag: true,
            showDragHandle: true,
            isScrollControlled: true,
            isDismissible: false,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: BlocProvider(
                create: (context) => LegalDocumentsPageBloc(),
                child: const SingleChildScrollView(child: DocumentsForm()),
              ),
            ),
          );
        },
      ),
      body: BlocConsumer<LegalDocumentsPageBloc, LegalDocumentsPageState>(
        builder: (context, state) {
          if (state.status.isInitial) {
            context
                .read<LegalDocumentsPageBloc>()
                .add(LoadLegalDocumentsEvent());
          }
          if (state.status.isSuccess) {
            return const LegalDocumentSuccessWidget();
          }
          if (state.status.isLoading) {
            return const GlobalLoadingWidget();
          }
          if (state.status.isEmpty) {
            return const NoDocumentsWidget();
          }
          if (state.status.isNotFound) {
            return const NotFoundWidget();
          }
          if (state.status.isError) {
            return const GlobalErrorWidget();
          }
          return const NoDocumentsWidget();
        },
        listener: (context, state) {
          if (state.status.isError) {
            Toast.show("An error occurred",
                duration: Toast.lengthShort, gravity: Toast.bottom);
          }
        },
      ),
    );
  }
}
