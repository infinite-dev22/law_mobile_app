import 'package:dirm_attorneys_mobile/legal_cases/presentation/widget/no_cases_widget.dart';
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
import '../bloc/legal_cases_page/legal_cases_page_bloc.dart';
import '../forms/cases_form.dart';
import '../widget/legal_case_success_widget.dart';

class LegalCasesPage extends StatelessWidget {
  const LegalCasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocConsumer<LegalCasesPageBloc, LegalCasesPageState>(
      builder: (blocContext, state) {
        if (state.status.isInitial ||
            state.status.isDeleted ||
            state.status.isDownloaded) {
          blocContext.read<LegalCasesPageBloc>().add(LoadLegalCasesEvent());
        }
        if (state.status.isSuccess ||
            state.status.isDeleteError ||
            state.status.isDownloadError ||
            state.status.isCaseError ||
            state.status.isCaseSuccess ||
            state.status.isCaseEdit) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Cases"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              drawer: const AppDrawer(),
              floatingActionButton: _fab(blocContext, context),
              body: const LegalCaseSuccessWidget());
        }
        if (state.status.isLoading || state.status.isCaseLoading) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Cases"),
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
                title: const Text("Cases"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              drawer: const AppDrawer(),
              floatingActionButton: _fab(blocContext, context),
              body: const NoCasesWidget());
        }
        if (state.status.isNotFound) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Cases"),
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
                title: const Text("Cases"),
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
              title: const Text("Cases"),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.lighterColor,
            ),
            drawer: const AppDrawer(),
            floatingActionButton: _fab(blocContext, context),
            body: const NoCasesWidget());
      },
      listener: (blocContext, state) {
        if (state.status.isError || state.status.isCaseError) {
          Toast.show("An error occurred",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
        if (state.status.isCaseLoading) {
          Toast.show("Loading issue",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
        if (state.status.isCaseSuccess) {
          showAdaptiveDialog(
            context: context,
            useSafeArea: true,
            builder: (context) {
              return _buildDetailDialog(blocContext, context, state);
            },
          );
        }
        if (state.status.isCaseEdit) {
          _displayCaseForm(blocContext, context);
        }
        if (state.status.isDownloaded) {
          GoRouter.of(context).pop();
        }
      },
    );
  }

  Widget _buildDetailDialog(BuildContext blocContext, BuildContext context,
      LegalCasesPageState state) {
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
            Text("Title: ${state.legalCase!.title!}"),
            Text("File: ${state.legalCase!.uploadedFileName!}"),
            Text("Assigned To: ${state.legalCase!.assignedTo ?? ""}"),
            Text("Status: ${state.legalCase!.issueStatus!}"),
            Text(
                "Created On: ${DateFormat('dd/MM/yyyy hh:mm a').format(state.legalCase!.createdAt!)}"),
            Text(
                "Last Updated: ${DateFormat('dd/MM/yyyy hh:mm a').format(state.legalCase!.updatedAt!)}"),
          ],
        ),
      ),
    );
  }

  Widget _fab(BuildContext blocContext, BuildContext context) {
    return FloatingActionButton(
      child: const Icon(FeatherIcons.plus),
      onPressed: () {
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
              create: (context) => LegalCasesPageBloc(),
              child: CasesForm(
                parentContext: blocContext,
              ),
            ),
          ),
        );
      },
    );
  }

  _displayCaseForm(BuildContext blocContext, BuildContext context) {
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
          create: (context) => LegalCasesPageBloc(),
          child: CasesForm(
            parentContext: blocContext,
          ),
        ),
      ),
    );
  }
}
