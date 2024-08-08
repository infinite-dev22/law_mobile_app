import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:toast/toast.dart';

import '../../../Global/Variables/colors.dart';
import '../../../Global/Widgets/app_drawer.dart';
import '../../../Global/Widgets/error_widget.dart';
import '../../../Global/Widgets/loading_widget.dart';
import '../../../Global/Widgets/not_found_widget.dart';
import '../bloc/legal_issues_page/legal_issues_pages_bloc.dart';
import '../forms/issues_form.dart';
import '../widget/legal_issue_success_widget.dart';
import '../widget/no_issues_widget.dart';

class LegalIssuesPage extends StatelessWidget {
  const LegalIssuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Issues"),
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
              child: Builder(
                builder: (context) => BlocProvider(
                  create: (context) => LegalIssuesPagesBloc(),
                  child: const SingleChildScrollView(child: IssuesForm()),
                ),
              ),
            ),
          );
        },
      ),
      body: BlocConsumer<LegalIssuesPagesBloc, LegalIssuesPageState>(
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
          if (state.status.isEmpty) {
            return const NoIssuesWidget();
          }
          if (state.status.isNotFound) {
            return const NotFoundWidget();
          }
          if (state.status.isError) {
            return const GlobalErrorWidget();
          }
          return const NoIssuesWidget();
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
