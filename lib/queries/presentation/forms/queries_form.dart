import 'dart:io';

import 'package:dirm_attorneys_mobile/Global/Widgets/loading_button.dart';
import 'package:dirm_attorneys_mobile/Global/Widgets/mwigo_text_area.dart';
import 'package:dirm_attorneys_mobile/Global/Widgets/mwigo_text_field.dart';
import 'package:dirm_attorneys_mobile/queries/data/model/query.dart';
import 'package:dirm_attorneys_mobile/queries/presentation/bloc/appointment_page/queries_page_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toast/toast.dart';

class QueriesForm extends StatefulWidget {
  final BuildContext parentContext;

  const QueriesForm({
    super.key,
    required this.parentContext,
  });

  @override
  State<QueriesForm> createState() => _QueriesFormState();
}

class _QueriesFormState extends State<QueriesForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isUpdate = false;

  PlatformFile? file;

  Future<void> _pickFile() async {
    FilePicker.platform
        .pickFiles(
          type: FileType.custom,
          allowedExtensions: [
            "pdf",
            "doc",
            "docx",
            "odt",
            "ods",
            "txt",
            "xls",
            "xlsx",
            "ppt",
            "pptx"
          ],
          dialogTitle: "Select Document",
        )
        .then(
          (value) => {
            if (value != null) {file = value.files.first},
            setState(() {}),
          },
        );
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocConsumer<QueriesPageBloc, QueriesPageState>(
      builder: (blocContext, state) {
        return LayoutBuilder(builder: (context, constraints) {
          return _buildBody(constraints, blocContext, state);
        });
      },
      listener: (BuildContext context, QueriesPageState state) {
        if (state.status.isPosted) {
          widget.parentContext.read<QueriesPageBloc>().add(LoadQueriesEvent());
          GoRouter.of(context).pop();
        }
        if (state.status.isPostError) {
          Toast.show(
            "An error occurred.",
            duration: Toast.lengthShort,
            gravity: Toast.bottom,
          );
        }
      },
    );
  }

  Widget _buildBody(BoxConstraints constraints, BuildContext blocContext,
      QueriesPageState state) {
    if (widget.parentContext.read<QueriesPageBloc>().state.query != null) {
      isUpdate = true;
      _titleController.text =
          widget.parentContext.read<QueriesPageBloc>().state.query!.title ?? "";
      _descriptionController.text = widget.parentContext
              .read<QueriesPageBloc>()
              .state
              .query!
              .description ??
          "";
    }

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: Text(
              "Query Form",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 8.0),
          MwigoTextField(
            label: "Title",
            controller: _titleController,
            disabled: state.status.isPosting,
          ),
          const SizedBox(height: 8),
          MwigoTextArea(
            label: "Description",
            controller: _descriptionController,
            disabled: state.status.isPosting,
          ),
          const SizedBox(height: 8),
          LoadingButton(
            text: file == null ? "Add attachment" : file!.name,
            disabled: state.status.isPosting,
            onTap: () => _pickFile(),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoadingButton(
                width: constraints.maxWidth * .3,
                text: "Cancel",
                outlined: true,
                disabled: state.status.isPosting,
                onTap: () {
                  GoRouter.of(context).pop();
                },
              ),
              LoadingButton(
                width: constraints.maxWidth * .6,
                text: "Create query",
                busy: state.status.isPosting,
                onTap: () {
                  setState(() {});
                  _submitForm(blocContext, state);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> _submitForm(
      BuildContext blocContext, QueriesPageState state) async {
    var query = Query.post(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      attachment: File(file!.path!),
    );

    context.read<QueriesPageBloc>().add(
        (isUpdate == true) ? UpdateQueryEvent(query) : AddQueryEvent(query));
  }
}
