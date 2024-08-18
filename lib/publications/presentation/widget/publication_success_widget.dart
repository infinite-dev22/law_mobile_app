import 'package:dirm_attorneys_mobile/Global/Widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:toast/toast.dart';

import '../bloc/publication_page/publications_page_bloc.dart';
import 'publication_item_widget.dart';

class PublicationSuccessWidget extends StatelessWidget {
  const PublicationSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocConsumer<PublicationsPageBloc, PublicationsPageState>(
      builder: (blocContext, state) {
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: state.publications!.length,
          itemBuilder: (context, index) => PublicationItem(
            data: state.publications!.elementAt(index),
            onTap: () {
              blocContext.read<PublicationsPageBloc>().add(GetPublicationEvent(
                  state.publications!.elementAt(index).slug!, false));
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
              blocContext.read<PublicationsPageBloc>().add(GetPublicationEvent(
                  state.publications!.elementAt(index).slug!, true));
            },
            onTapDownload: () {
              blocContext.read<PublicationsPageBloc>().add(
                  DownloadPublicationEvent(
                      state.publications!.elementAt(index).slug!));
            },
          ),
        );
      },
      listener: (blocContext, state) {
        if (state.status.isDeleting) {
          Toast.show("Deleting publication",
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
                      Text("Downloading publication document"),
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
          blocContext.read<PublicationsPageBloc>().add(LoadPublicationsEvent());
          GoRouter.of(context).pop();
        }
        if (state.status.isDownloaded) {
          Toast.show("Document downloaded successfully",
              duration: Toast.lengthShort, gravity: Toast.bottom);
          GoRouter.of(context).pop();
        }
        if (state.status.isDeleteError) {
          Toast.show("An error occurred deleting the publication document",
              duration: Toast.lengthShort, gravity: Toast.bottom);
          GoRouter.of(context).pop();
        }
        if (state.status.isDownloadError) {
          Toast.show("An error occurred downloading the publication document",
              duration: Toast.lengthShort, gravity: Toast.bottom);
          GoRouter.of(context).pop();
        }
      },
    );
  }

  Widget _deleteDialog(BuildContext blocContext, BuildContext context,
      PublicationsPageState state, int index) {
    return AlertDialog.adaptive(
      icon: const Icon(
        FeatherIcons.trash2,
        color: Colors.redAccent,
      ),
      title: const Text("Delete publication"),
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
              blocContext.read<PublicationsPageBloc>().add(
                  DeletePublicationEvent(
                      state.publications!.elementAt(index).slug!));
              GoRouter.of(context).pop();
            })
      ],
    );
  }
}
