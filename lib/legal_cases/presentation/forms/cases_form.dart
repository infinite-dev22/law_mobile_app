import 'dart:io';

import 'package:dirm_attorneys_mobile/Global/Widgets/loading_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toast/toast.dart';

import '../../../Global/Widgets/mwigo_text_area.dart';
import '../../../Global/Widgets/mwigo_text_field.dart';
import '../../data/model/legal_case.dart';
import '../bloc/legal_cases_page/legal_cases_page_bloc.dart';

class CasesForm extends StatefulWidget {
  final BuildContext parentContext;

  const CasesForm({
    super.key,
    required this.parentContext,
  });

  @override
  State<CasesForm> createState() => _CasesFormState();
}

class _CasesFormState extends State<CasesForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isUpdate = false;
  String? slug;

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

    return BlocConsumer<LegalCasesPageBloc, LegalCasesPageState>(
      builder: (blocContext, state) {
        return LayoutBuilder(builder: (context, constraints) {
          return _buildBody(constraints, blocContext, state);
        });
      },
      listener: (BuildContext context, LegalCasesPageState state) {
        if (state.status.isPosted) {
          widget.parentContext
              .read<LegalCasesPageBloc>()
              .add(LoadLegalCasesEvent());
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
      LegalCasesPageState state) {
    if (widget.parentContext.read<LegalCasesPageBloc>().state.legalCase !=
        null) {
      isUpdate = true;
      _titleController.text = widget.parentContext
              .read<LegalCasesPageBloc>()
              .state
              .legalCase!
              .title ??
          "";
      _descriptionController.text = widget.parentContext
              .read<LegalCasesPageBloc>()
              .state
              .legalCase!
              .description ??
          "";
      slug =
          widget.parentContext.read<LegalCasesPageBloc>().state.legalCase!.slug;
    }

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: Text(
              "Case Form",
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
                text: "Create case",
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
      BuildContext blocContext, LegalCasesPageState state) async {
    var legalCase = LegalCase.post(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      file: File(file!.path!),
      slug: slug,
    );

    context.read<LegalCasesPageBloc>().add((isUpdate == true)
        ? LegalCasePutEvent(legalCase)
        : LegalCasePostEvent(legalCase));
  }
}
