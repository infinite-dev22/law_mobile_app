import 'package:dirm_attorneys_mobile/legal_cases/presentation/widget/no_cases_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:toast/toast.dart';

import '../../../Global/Variables/colors.dart';
import '../../../Global/Widgets/app_drawer.dart';
import '../../../Global/Widgets/error_widget.dart';
import '../../../Global/Widgets/loading_widget.dart';
import '../../../Global/Widgets/not_found_widget.dart';
import '../bloc/legal_cases_page/legal_cases_page_bloc.dart';
import '../forms/cases_form.dart';
import '../widget/legal_case_success_widget.dart';

class LegalCasesPage extends StatelessWidget {
  const LegalCasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cases"),
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
                create: (context) => LegalCasesPageBloc(),
                child: const SingleChildScrollView(child: CasesForm()),
              ),
            ),
          );
        },
      ),
      body: BlocConsumer<LegalCasesPageBloc, LegalCasesPageState>(
        builder: (context, state) {
          if (state.status.isInitial) {
            context.read<LegalCasesPageBloc>().add(LoadLegalCasesEvent());
          }
          if (state.status.isSuccess) {
            return const LegalCaseSuccessWidget();
          }
          if (state.status.isLoading) {
            return const GlobalLoadingWidget();
          }
          if (state.status.isEmpty) {
            return const NoCasesWidget();
          }
          if (state.status.isNotFound) {
            return const NotFoundWidget();
          }
          if (state.status.isError) {
            return const GlobalErrorWidget();
          }
          return const NoCasesWidget();
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
