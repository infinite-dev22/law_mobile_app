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
import '../bloc/publication_page/publications_page_bloc.dart';
import '../forms/publications_form.dart';
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
              drawer: const AppDrawer(),
              floatingActionButton:
                  _displayPublicationForm(blocContext, context),
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
              drawer: const AppDrawer(),
              floatingActionButton:
                  _displayPublicationForm(blocContext, context),
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
              drawer: const AppDrawer(),
              floatingActionButton:
                  _displayPublicationForm(blocContext, context),
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
              drawer: const AppDrawer(),
              floatingActionButton:
                  _displayPublicationForm(blocContext, context),
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
              drawer: const AppDrawer(),
              floatingActionButton:
                  _displayPublicationForm(blocContext, context),
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
            floatingActionButton: _displayPublicationForm(blocContext, context),
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
        if (state.status.isPublicationEdit) {
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
                create: (context) => PublicationsPageBloc(),
                child: SingleChildScrollView(
                  child: PublicationsForm(
                    parentContext: blocContext,
                  ),
                ),
              ),
            ),
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

  Widget _displayPublicationForm(
      BuildContext blocContext, BuildContext context) {
    return FloatingActionButton(
      child: const Icon(FeatherIcons.plus),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isDismissible: false,
          useSafeArea: true,
          builder: (context) => AnimatedPadding(
            padding: const EdgeInsets.all(8.0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: BlocProvider(
              create: (context) => PublicationsPageBloc(),
              child: PublicationsForm(
                parentContext: blocContext,
              ),
            ),
          ),
        );
      },
    );
  }
}
