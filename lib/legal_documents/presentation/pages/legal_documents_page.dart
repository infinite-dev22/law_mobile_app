import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../../../Global/Variables/colors.dart';
import '../../../Global/Widgets/error_widget.dart';
import '../../../Global/Widgets/initial_widget.dart';
import '../../../Global/Widgets/loading_widget.dart';
import '../bloc/legal_documents_page/legal_documents_page_bloc.dart';
import '../widget/legal_document_success_widget.dart';

class LegalDocumentsPage extends StatelessWidget {
  const LegalDocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocConsumer<LegalDocumentsPageBloc, LegalDocumentsPageState>(
      builder: (context, state) {
        if (state.status.isInitial) {
          context.read<LegalDocumentsPageBloc>().add(LoadLegalDocumentsEvent());
        }
        if (state.status.isSuccess) {
          return const LegalDocumentSuccessWidget();
        }
        if (state.status.isLoading) {
          return const GlobalLoadingWidget();
        }
        if (state.status.isError) {
          return const GlobalErrorWidget();
        }
        return const GlobalInitialWidget();
      },
      listener: (context, state) {
        if (state.status.isInitial) {
          Toast.show("Initial State",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
        if (state.status.isSuccess) {
          Toast.show("Success State",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
        if (state.status.isLoading) {
          Toast.show("Loading State",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
        if (state.status.isError) {
          Toast.show("Error State",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
      },
    );
  }
}
