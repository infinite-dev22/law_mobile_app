import 'dart:io';

import 'package:dirm_attorneys_mobile/Global/Widgets/loading_button.dart';
import 'package:dirm_attorneys_mobile/legal_issues/data/model/legal_issue.dart';
import 'package:dirm_attorneys_mobile/legal_issues/presentation/bloc/legal_issues_page/legal_issues_pages_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toast/toast.dart';

import '../../../Global/Widgets/mwigo_text_area.dart';
import '../../../Global/Widgets/mwigo_text_field.dart';

class IssuesForm extends StatefulWidget {
  final BuildContext parentContext;

  const IssuesForm({
    super.key,
    required this.parentContext,
  });

  @override
  State<IssuesForm> createState() => _IssuesFormState();
}

class _IssuesFormState extends State<IssuesForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

    return BlocConsumer<LegalIssuesPagesBloc, LegalIssuesPageState>(
      bloc: LegalIssuesPagesBloc(),
      builder: (blocContext, state) {
        return LayoutBuilder(builder: (context, constraints) {
          return _buildBody(constraints, blocContext, state);
        });
      },
      listener: (BuildContext context, LegalIssuesPageState state) {
        if (state.status.isPosted) {
          widget.parentContext
              .read<LegalIssuesPagesBloc>()
              .add(LoadLegalIssuesEvent());
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
      LegalIssuesPageState state) {
    if (widget.parentContext.read<LegalIssuesPagesBloc>().state.issue != null) {
      _titleController.text = widget.parentContext
              .read<LegalIssuesPagesBloc>()
              .state
              .issue!
              .title ??
          "";
      _descriptionController.text = widget.parentContext
              .read<LegalIssuesPagesBloc>()
              .state
              .issue!
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
              "Issue Form",
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
            text: file == null ? "Attach Document" : file!.name,
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
                text: "Create issue",
                busy: state.status.isPosting,
                onTap: () {
                  setState(() {});
                  if (file != null) {
                    _submitForm(blocContext, state);
                  } else {
                    Toast.show(
                      "Document is required",
                      duration: Toast.lengthLong,
                      gravity: Toast.bottom,
                    );
                  }
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
      BuildContext blocContext, LegalIssuesPageState state) async {
    var legalIssue = LegalIssue.post(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      file: File(file!.path!),
    );

    context.read<LegalIssuesPagesBloc>().add(LegalIssuePostEvent(legalIssue));
  }
}
