import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import '../../../Global/Variables/colors.dart';
import '../../../Global/Widgets/app_drawer.dart';
import '../../../Global/Widgets/error_widget.dart';
import '../../../Global/Widgets/loading_widget.dart';
import '../../../Global/Widgets/not_found_widget.dart';
import '../bloc/publication_page/publications_page_bloc.dart';
import '../widget/no_publications_widget.dart';
import '../widget/publication_success_widget.dart';

class PublicationsPage extends StatelessWidget {
  const PublicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocConsumer<PublicationsPageBloc, PublicationsPageState>(
      builder: (blocContext, state) {
        if (state.status.isInitial ||
            state.status.isDeleted ||
            state.status.isDownloaded) {
          blocContext.read<PublicationsPageBloc>().add(LoadPublicationsEvent());
        }
        if (state.status.isSuccess ||
            state.status.isDeleteError ||
            state.status.isDownloadError ||
            state.status.isPublicationError ||
            state.status.isPublicationSuccess ||
            state.status.isPublicationEdit) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Publications"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              body: const PublicationSuccessWidget());
        }
        if (state.status.isLoading || state.status.isPublicationLoading) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Publications"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              body: const GlobalLoadingWidget());
        }
        if (state.status.isEmpty) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Publications"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              body: const NoPublicationsWidget());
        }
        if (state.status.isNotFound) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Publications"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              body: const NotFoundWidget());
        }
        if (state.status.isError) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Publications"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              body: const GlobalErrorWidget());
        }
        return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text("Publications"),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.lighterColor,
            ),
            drawer: const AppDrawer(),
            body: const NoPublicationsWidget());
      },
      listener: (blocContext, state) {
        if (state.status.isError || state.status.isPublicationError) {
          Toast.show("An error occurred",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
        if (state.status.isPublicationLoading) {
          Toast.show("Loading publication",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
        if (state.status.isPublicationSuccess) {
          showAdaptiveDialog(
            context: context,
            useSafeArea: true,
            builder: (context) {
              return _buildDetailDialog(blocContext, context, state);
            },
          );
        }
      },
    );
  }

  Widget _buildDetailDialog(BuildContext blocContext, BuildContext context,
      PublicationsPageState state) {
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
            Text("Title: ${state.publication!.title!}"),
            Text("File: ${state.publication!.uploadedFileName!}"),
            Text("Assigned To: ${state.publication!.assignedTo ?? ""}"),
            Text("Status: ${state.publication!.issueStatus!}"),
            Text(
                "Created On: ${DateFormat('dd/MM/yyyy hh:mm a').format(state.publication!.createdAt!)}"),
            Text(
                "Last Updated: ${DateFormat('dd/MM/yyyy hh:mm a').format(state.publication!.updatedAt!)}"),
          ],
        ),
      ),
    );
  }
}
