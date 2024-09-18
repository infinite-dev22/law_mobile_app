import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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

    return BlocConsumer<LegalDocumentsPageBloc, LegalDocumentsPageState>(
      builder: (blocContext, state) {
        if (state.status.isInitial ||
            state.status.isDeleted ||
            state.status.isDownloaded) {
          blocContext
              .read<LegalDocumentsPageBloc>()
              .add(LoadLegalDocumentsEvent());
        }
        if (state.status.isSuccess ||
            state.status.isDeleteError ||
            state.status.isDownloadError ||
            state.status.isDocumentError ||
            state.status.isDocumentSuccess ||
            state.status.isDocumentEdit) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Documents"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              drawer: const AppDrawer(),
              floatingActionButton: _fab(blocContext, context),
              body: const LegalDocumentSuccessWidget());
        }
        if (state.status.isLoading || state.status.isDocumentLoading) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Documents"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              drawer: const AppDrawer(),
              floatingActionButton: _fab(blocContext, context),
              body: const GlobalLoadingWidget());
        }
        if (state.status.isEmpty) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Documents"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              drawer: const AppDrawer(),
              floatingActionButton: _fab(blocContext, context),
              body: const NoDocumentsWidget());
        }
        if (state.status.isNotFound) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Documents"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              drawer: const AppDrawer(),
              floatingActionButton: _fab(blocContext, context),
              body: const NotFoundWidget());
        }
        if (state.status.isError) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Documents"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              drawer: const AppDrawer(),
              floatingActionButton: _fab(blocContext, context),
              body: const GlobalErrorWidget());
        }
        return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text("Documents"),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.lighterColor,
            ),
            drawer: const AppDrawer(),
            floatingActionButton: _fab(blocContext, context),
            body: const NoDocumentsWidget());
      },
      listener: (blocContext, state) {
        if (state.status.isError || state.status.isDocumentError) {
          Toast.show("An error occurred",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
        if (state.status.isDocumentLoading) {
          Toast.show("Loading document",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
        if (state.status.isDocumentSuccess) {
          showAdaptiveDialog(
            context: context,
            useSafeArea: true,
            builder: (context) {
              return _buildDetailDialog(blocContext, context, state);
            },
          );
        }
        if (state.status.isDocumentEdit) {
          _displayDocumentForm(blocContext, context);
        }
        if (state.status.isDownloaded) {
          GoRouter.of(context).pop();
        }
      },
    );
  }

  Widget _buildDetailDialog(BuildContext blocContext, BuildContext context,
      LegalDocumentsPageState state) {
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
            Text("Title: ${state.document!.title!}"),
            Text("File: ${state.document!.uploadedFileName!}"),
            Text("Assigned To: ${state.document!.assignedTo ?? ""}"),
            Text("Status: ${state.document!.issueStatus!}"),
            Text(
                "Created On: ${DateFormat('dd/MM/yyyy hh:mm a').format(state.document!.createdAt!)}"),
            Text(
                "Last Updated: ${DateFormat('dd/MM/yyyy hh:mm a').format(state.document!.updatedAt!)}"),
          ],
        ),
      ),
    );
  }

  Widget _fab(BuildContext blocContext, BuildContext context) {
    return FloatingActionButton(
      child: const Icon(FeatherIcons.plus),
      onPressed: () {
        _displayDocumentForm(blocContext, context);
      },
    );
  }

  _displayDocumentForm(BuildContext blocContext, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) => AnimatedPadding(
        padding: const EdgeInsets.all(8.0).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: BlocProvider(
          create: (context) => LegalDocumentsPageBloc(),
          child: DocumentsForm(
            parentContext: blocContext,
          ),
        ),
      ),
    );
  }
}
