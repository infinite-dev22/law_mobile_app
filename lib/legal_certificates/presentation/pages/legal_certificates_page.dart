import 'package:dirm_attorneys_mobile/legal_certificates/presentation/widget/no_certificates_widget.dart';
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
import '../bloc/legal_certificates_page/legal_certificates_page_bloc.dart';
import '../forms/certificates_form.dart';
import '../widget/legal_certificate_success_widget.dart';

class LegalCertificatesPage extends StatelessWidget {
  const LegalCertificatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocConsumer<LegalCertificatesPageBloc, LegalCertificatesPageState>(
      builder: (blocContext, state) {
        if (state.status.isInitial ||
            state.status.isDeleted ||
            state.status.isDownloaded) {
          blocContext
              .read<LegalCertificatesPageBloc>()
              .add(LoadLegalCertificatesEvent());
        }
        if (state.status.isSuccess ||
            state.status.isDeleteError ||
            state.status.isDownloadError ||
            state.status.isCertificateError ||
            state.status.isCertificateSuccess ||
            state.status.isCertificateEdit) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Certificates"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              drawer: const AppDrawer(),
              floatingActionButton:
                  _displayCertificateForm(blocContext, context),
              body: const LegalCertificateSuccessWidget());
        }
        if (state.status.isLoading || state.status.isCertificateLoading) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Certificates"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              drawer: const AppDrawer(),
              floatingActionButton:
                  _displayCertificateForm(blocContext, context),
              body: const GlobalLoadingWidget());
        }
        if (state.status.isEmpty) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Certificates"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              drawer: const AppDrawer(),
              floatingActionButton:
                  _displayCertificateForm(blocContext, context),
              body: const NoCertificatesWidget());
        }
        if (state.status.isNotFound) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Certificates"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              drawer: const AppDrawer(),
              floatingActionButton:
                  _displayCertificateForm(blocContext, context),
              body: const NotFoundWidget());
        }
        if (state.status.isError) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text("Certificates"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              drawer: const AppDrawer(),
              floatingActionButton:
                  _displayCertificateForm(blocContext, context),
              body: const GlobalErrorWidget());
        }
        return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text("Certificates"),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.lighterColor,
            ),
            drawer: const AppDrawer(),
            floatingActionButton: _displayCertificateForm(blocContext, context),
            body: const NoCertificatesWidget());
      },
      listener: (blocContext, state) {
        if (state.status.isError || state.status.isCertificateError) {
          Toast.show("An error occurred",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
        if (state.status.isCertificateLoading) {
          Toast.show("Loading certificate",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        }
        if (state.status.isCertificateSuccess) {
          showAdaptiveDialog(
            context: context,
            useSafeArea: true,
            builder: (context) {
              return _buildDetailDialog(blocContext, context, state);
            },
          );
        }
        if (state.status.isCertificateEdit) {
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
                create: (context) => LegalCertificatesPageBloc(),
                child: SingleChildScrollView(
                  child: CertificatesForm(
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
      LegalCertificatesPageState state) {
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
            Text("Title: ${state.certificate!.title!}"),
            Text("File: ${state.certificate!.uploadedFileName!}"),
            Text("Assigned To: ${state.certificate!.assignedTo ?? ""}"),
            Text("Status: ${state.certificate!.issueStatus!}"),
            Text(
                "Created On: ${DateFormat('dd/MM/yyyy hh:mm a').format(state.certificate!.createdAt!)}"),
            Text(
                "Last Updated: ${DateFormat('dd/MM/yyyy hh:mm a').format(state.certificate!.updatedAt!)}"),
          ],
        ),
      ),
    );
  }

  Widget _displayCertificateForm(
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
              create: (context) => LegalCertificatesPageBloc(),
              child: CertificatesForm(
                parentContext: blocContext,
              ),
            ),
          ),
        );
      },
    );
  }
}
