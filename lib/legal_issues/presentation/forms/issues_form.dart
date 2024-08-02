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
  const IssuesForm({super.key});

  @override
  State<IssuesForm> createState() => _IssuesFormState();
}

class _IssuesFormState extends State<IssuesForm> {
  PlatformFile? file;

  Future<void> _pickFile() async {
    FilePicker.platform.pickFiles().then(
          (value) => {
            if (value != null) {file = value.files.first}
          },
        );
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocConsumer<LegalIssuesPagesBloc, LegalIssuesPageState>(
      builder: (blocContext, state) {
        return LayoutBuilder(builder: (context, constraints) {
          return _buildBody(constraints, blocContext, state);
        });
      },
      listener: (BuildContext context, LegalIssuesPageState state) {
        if (state.status.isPosted) {
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
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              MwigoTextField(
                label: "Title",
                controller: _titleController,
                disabled: state.status.isPosting || state.status.isPostError,
              ),
              const SizedBox(height: 8),
              MwigoTextArea(
                label: "Description",
                controller: _descriptionController,
                disabled: state.status.isPosting || state.status.isPostError,
              ),
              const SizedBox(height: 8),
              LoadingButton(
                text: file == null ? "Attach Document" : file!.name,
                disabled: state.status.isPosting || state.status.isPostError,
                onTap: () => _pickFile(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoadingButton(
                width: constraints.maxWidth * .3,
                text: "Cancel",
                outlined: true,
                disabled: state.status.isPosting || state.status.isPostError,
                onTap: () {
                  setState(() {});
                },
              ),
              LoadingButton(
                width: constraints.maxWidth * .6,
                text: "Create issue",
                busy: state.status.isPosting || state.status.isPostError,
                onTap: () {
                  setState(() {});
                  _submitForm(blocContext, state);
                },
              ),
            ],
          ),
          const SizedBox(),
        ],
      ),
    );
  }

  void _submitForm(BuildContext blocContext, LegalIssuesPageState state) {
    var legalIssue = LegalIssue.post(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      adviceFilePath: file,
    );

    context.read<LegalIssuesPagesBloc>().add(LegalIssuePostEvent(legalIssue));
  }
}
