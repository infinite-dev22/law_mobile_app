import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
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
          if (state.status.isInitial ||
              state.status.isDeleted ||
              state.status.isDownloaded) {
            context.read<LegalIssuesPagesBloc>().add(LoadLegalIssuesEvent());
          }
          if (state.status.isSuccess ||
              state.status.isDeleteError ||
              state.status.isDownloadError ||
              state.status.isIssueError ||
              state.status.isIssueSuccess) {
            return const LegalIssueSuccessWidget();
          }
          if (state.status.isLoading || state.status.isIssueLoading) {
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
        listener: (blocContext, state) {
          if (state.status.isError || state.status.isIssueError) {
            Toast.show("An error occurred",
                duration: Toast.lengthShort, gravity: Toast.bottom);
          }
          if (state.status.isIssueLoading) {
            Toast.show("Loading issue",
                duration: Toast.lengthShort, gravity: Toast.bottom);
          }
          if (state.status.isIssueSuccess) {
            showAdaptiveDialog(
              context: context,
              useSafeArea: true,
              builder: (context) {
                return _buildDetailDialog(blocContext, context, state);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildDetailDialog(BuildContext blocContext, BuildContext context,
      LegalIssuesPageState state) {
    return AlertDialog.adaptive(
      scrollable: true,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).colorScheme.secondary,
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title: ${state.issue!.title!}"),
            Text("File: ${state.issue!.uploadedFileName!}"),
            Text("Assigned To: ${state.issue!.assignedTo ?? ""}"),
            Text("Status: ${state.issue!.issueStatus!}"),
            Text(
                "Created On: ${DateFormat('dd/MM/yyyy hh:mm a').format(state.issue!.createdAt!)}"),
            Text(
                "Last Updated: ${DateFormat('dd/MM/yyyy hh:mm a').format(state.issue!.updatedAt!)}"),
          ],
        ),
      ),
    );
  }
}
