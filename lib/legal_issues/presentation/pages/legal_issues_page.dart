import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../../../Global/Widgets/error_widget.dart';
import '../../../Global/Widgets/initial_widget.dart';
import '../../../Global/Widgets/loading_widget.dart';
import '../bloc/legal_issues_page/legal_issues_pages_bloc.dart';
import '../widget/legal_issue_success_widget.dart';

class LegalIssuesPage extends StatelessWidget {
  const LegalIssuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocConsumer<LegalIssuesPagesBloc, LegalIssuesPageState>(
      builder: (context, state) {
        if (state.status.isInitial) {
          context.read<LegalIssuesPagesBloc>().add(LoadLegalIssuesEvent());
        }
        if (state.status.isSuccess) {
          return const LegalIssueSuccessWidget();
        }
        if (state.status.isLoading) {
          return const GlobalLoadingWidget();
        }
        if (state.status.isError) {
          return const GlobalErrorWidget();
        }
        return const GlobalLoadingWidget();
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
