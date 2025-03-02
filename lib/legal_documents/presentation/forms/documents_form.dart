import 'dart:io';

import 'package:dirm_attorneys_mobile/Global/Widgets/loading_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toast/toast.dart';

import '../../../Global/Widgets/mwigo_text_field.dart';
import '../../data/model/legal_document.dart';
import '../bloc/legal_documents_page/legal_documents_page_bloc.dart';

class DocumentsForm extends StatefulWidget {
  final BuildContext parentContext;

  @override
  State<DocumentsForm> createState() => _DocumentsFormState();

  const DocumentsForm({
    super.key,
    required this.parentContext,
  });
}

class _DocumentsFormState extends State<DocumentsForm> {
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

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocConsumer<LegalDocumentsPageBloc, LegalDocumentsPageState>(
      builder: (blocContext, state) {
        return LayoutBuilder(builder: (context, constraints) {
          return _buildBody(constraints, blocContext, state);
        });
      },
      listener: (BuildContext context, LegalDocumentsPageState state) {
        if (state.status.isPosted) {
          widget.parentContext
              .read<LegalDocumentsPageBloc>()
              .add(LoadLegalDocumentsEvent());
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
      LegalDocumentsPageState state) {
    if (widget.parentContext.read<LegalDocumentsPageBloc>().state.document !=
        null) {
      isUpdate = true;
      _titleController.text = widget.parentContext
              .read<LegalDocumentsPageBloc>()
              .state
              .document!
              .title ??
          "";
      slug = widget.parentContext
              .read<LegalDocumentsPageBloc>()
              .state
              .document!
              .slug;
    }

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: Text(
              "Document Form",
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
                text: "Create document",
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
      BuildContext blocContext, LegalDocumentsPageState state) async {
    var legalDocument = LegalDocument.post(
      title: _titleController.text.trim(),
      file: File(file!.path!),
      slug: slug,
    );

    context
        .read<LegalDocumentsPageBloc>()
        .add((isUpdate == true)
        ? LegalDocumentPutEvent(legalDocument):LegalDocumentPostEvent(legalDocument));
  }
}
