import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/legal_issues_page/legal_issues_pages_bloc.dart';
import 'legal_issue_item_widget.dart';

class LegalIssueSuccessWidget extends StatelessWidget {
  const LegalIssueSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LegalIssuesPagesBloc, LegalIssuesPageState>(
      builder: (context, state) {
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: state.issues!.length,
          itemBuilder: (context, index) => LegalIssueItem(
            data: state.issues!.elementAt(index),
            onTap: () {
              print("Tapped View Item $index");
            },
            onTapDelete: () {
              context.read<LegalIssuesPagesBloc>().add(
                  DeleteLegalIssueEvent(state.issues!.elementAt(index).slug!));
            },
            onTapDownload: () {
              context.read<LegalIssuesPagesBloc>().add(DownloadLegalIssueEvent(
                  state.issues!.elementAt(index).slug!));
            },
          ),
        );
      },
      listener: (context, state) {
        if (state.status.isDeleting) {
          showAdaptiveDialog(
            context: context,
            builder: (context) {
              return const Column(
                children: [
                  Text("Deleting issue"),
                  CircularProgressIndicator.adaptive(),
                ],
              );
            },
          );
        }
        if (state.status.isDownloading) {
          showAdaptiveDialog(
            context: context,
            builder: (context) {
              return const Column(
                children: [
                  Text("Downloading issue document"),
                  CircularProgressIndicator.adaptive(),
                ],
              );
            },
          );
        }
        if (state.status.isDeleted) {
          showAdaptiveDialog(
            context: context,
            builder: (context) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    size: 80,
                    color: Colors.green,
                  ),
                  Text("Deleted issue"),
                ],
              );
            },
          );
        }
        if (state.status.isDownloaded) {
          showAdaptiveDialog(
            context: context,
            builder: (context) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    size: 80,
                    color: Colors.green,
                  ),
                  Text("Downloaded issue document"),
                ],
              );
            },
          );
        }
        if (state.status.isDeleteError) {
          showAdaptiveDialog(
            context: context,
            builder: (context) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 80,
                    color: Colors.redAccent,
                  ),
                  Text("An error occurred Deleting issue"),
                ],
              );
            },
          );
        }
        if (state.status.isDownloadError) {
          showAdaptiveDialog(
            context: context,
            builder: (context) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 80,
                    color: Colors.redAccent,
                  ),
                  Text("An error occurred Downloading issue document"),
                ],
              );
            },
          );
        }
      },
    );
  }
}
