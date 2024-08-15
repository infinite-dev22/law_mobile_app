import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:toast/toast.dart';

import '../../../Global/Widgets/loading_button.dart';
import '../bloc/legal_certificates_page/legal_certificates_page_bloc.dart';
import 'legal_certificate_item_widget.dart';

class LegalCertificateSuccessWidget extends StatelessWidget {
  const LegalCertificateSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocConsumer<LegalCertificatesPageBloc, LegalCertificatesPageState>(
      builder: (blocContext, state) {
        return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.certificates!.length,
            itemBuilder: (context, index) => LegalCertificateItem(
                  data: state.certificates!.elementAt(index),
                  onTap: () {
                    blocContext.read<LegalCertificatesPageBloc>().add(
                        GetLegalCertificateEvent(
                            state.certificates!.elementAt(index).slug!, false));
                  },
                  onTapDelete: () {
                    showAdaptiveDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return _deleteDialog(
                            blocContext, context, state, index);
                      },
                    );
                  },
                  onTapEdit: () {
                    blocContext.read<LegalCertificatesPageBloc>().add(
                        GetLegalCertificateEvent(
                            state.certificates!.elementAt(index).slug!, true));
                  },
                  onTapDownload: () {
                    blocContext.read<LegalCertificatesPageBloc>().add(
                        DownloadLegalCertificateEvent(
                            state.certificates!.elementAt(index).slug!));
                  },
                ));
      },
      listener: (blocContext, state) {
        if (state.status.isDeleting) {
          Toast.show("Deleting certificate",
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
                      Text("Downloading certificate document"),
                      CircularProgressIndicator.adaptive(),
                    ],
                  ),
                ),
              );
            },
          );
        }
        if (state.status.isDeleted) {
          Toast.show("Certificate deleted successfully",
              duration: Toast.lengthShort, gravity: Toast.bottom);
          blocContext
              .read<LegalCertificatesPageBloc>()
              .add(LoadLegalCertificatesEvent());
          GoRouter.of(context).pop();
        }
        if (state.status.isDownloaded) {
          Toast.show("Document downloaded successfully",
              duration: Toast.lengthShort, gravity: Toast.bottom);
          GoRouter.of(context).pop();
        }
        if (state.status.isDeleteError) {
          Toast.show("An error occurred deleting the certificate document",
              duration: Toast.lengthShort, gravity: Toast.bottom);
          GoRouter.of(context).pop();
        }
        if (state.status.isDownloadError) {
          Toast.show("An error occurred downloading the certificate document",
              duration: Toast.lengthShort, gravity: Toast.bottom);
          GoRouter.of(context).pop();
        }
      },
    );
  }

  Widget _deleteDialog(BuildContext blocContext, BuildContext context,
      LegalCertificatesPageState state, int index) {
    return AlertDialog.adaptive(
      icon: const Icon(
        FeatherIcons.trash2,
        color: Colors.redAccent,
      ),
      title: const Text("Delete certificate"),
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
              blocContext.read<LegalCertificatesPageBloc>().add(
                  DeleteLegalCertificateEvent(
                      state.certificates!.elementAt(index).slug!));
              GoRouter.of(context).pop();
            })
      ],
    );
  }
}
