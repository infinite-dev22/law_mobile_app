import 'package:dirm_attorneys_mobile/Global/Widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:toast/toast.dart';

import '../bloc/legal_issues_page/legal_issues_pages_bloc.dart';
import 'legal_issue_item_widget.dart';

class LegalIssueSuccessWidget extends StatelessWidget {
  const LegalIssueSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocConsumer<LegalIssuesPagesBloc, LegalIssuesPageState>(
      builder: (blocContext, state) {
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: state.issues!.length,
          itemBuilder: (context, index) => LegalIssueItem(
            data: state.issues!.elementAt(index),
            onTap: () {
              blocContext.read<LegalIssuesPagesBloc>().add(GetLegalIssueEvent(
                  state.issues!.elementAt(index).slug!, false));
            },
            onTapDelete: () {
              showAdaptiveDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return _deleteDialog(blocContext, context, state, index);
                },
              );
            },
            onTapEdit: () {
              blocContext.read<LegalIssuesPagesBloc>().add(GetLegalIssueEvent(
                  state.issues!.elementAt(index).slug!, true));
            },
            onTapDownload: () {
              blocContext.read<LegalIssuesPagesBloc>().add(
                  DownloadLegalIssueUploadedDocumentEvent(
                      state.issues!.elementAt(index).slug!));
            },
          ),
        );
      },
      listener: (blocContext, state) {
        if (state.status.isDeleting) {
          Toast.show("Deleting issue",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
        if (state.status.isDownloading) {
          showAdaptiveDialog(
            context: context,
            builder: (context) {
              return AlertDialog.adaptive(
                content: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Downloading issue document"),
                      CircularProgressIndicator.adaptive(),
                    ],
                  ),
                ),
              );
            },
          );
        }
        if (state.status.isDeleted) {
          Toast.show("Issue deleted successfully",
              duration: Toast.lengthShort, gravity: Toast.bottom);
          blocContext.read<LegalIssuesPagesBloc>().add(LoadLegalIssuesEvent());
          GoRouter.of(context).pop();
        }
        if (state.status.isDownloaded) {
          Toast.show("Document downloaded successfully",
              duration: Toast.lengthShort, gravity: Toast.bottom);
          GoRouter.of(context).pop();
        }
        if (state.status.isDeleteError) {
          Toast.show("An error occurred deleting the issue document",
              duration: Toast.lengthShort, gravity: Toast.bottom);
          GoRouter.of(context).pop();
        }
        if (state.status.isDownloadError) {
          Toast.show("An error occurred downloading the issue document",
              duration: Toast.lengthShort, gravity: Toast.bottom);
          GoRouter.of(context).pop();
        }
      },
    );
  }

  Widget _deleteDialog(BuildContext blocContext, BuildContext context,
      LegalIssuesPageState state, int index) {
    return AlertDialog.adaptive(
      icon: const Icon(
        FeatherIcons.trash2,
        color: Colors.redAccent,
      ),
      title: const Text("Delete issue"),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).colorScheme.secondary,
        ),
        padding: const EdgeInsets.all(8.0),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure?",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "This action can not be un-done.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      actions: [
        LoadingButton(
          text: "No, cancel",
          width: 120,
          onTap: () {
            GoRouter.of(context).pop();
          },
        ),
        LoadingButton(
            text: "Yes, proceed",
            width: 120,
            outlined: true,
            busy: state.status.isDeleting,
            onTap: () {
              blocContext.read<LegalIssuesPagesBloc>().add(
                  DeleteLegalIssueEvent(state.issues!.elementAt(index).slug!));
              GoRouter.of(context).pop();
            })
      ],
    );
  }
}
