import 'dart:io';

import 'package:dirm_attorneys_mobile/Global/Widgets/loading_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toast/toast.dart';

import '../../../Global/Widgets/mwigo_text_area.dart';
import '../../../Global/Widgets/mwigo_text_field.dart';
import '../../data/model/legal_certificate.dart';
import '../bloc/legal_certificates_page/legal_certificates_page_bloc.dart';

class CertificatesForm extends StatefulWidget {
  final BuildContext parentContext;

  const CertificatesForm({
    super.key,
    required this.parentContext,
  });

  @override
  State<CertificatesForm> createState() => _CertificatesFormState();
}

class _CertificatesFormState extends State<CertificatesForm> {
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

    return BlocConsumer<LegalCertificatesPageBloc, LegalCertificatesPageState>(
      builder: (blocContext, state) {
        return LayoutBuilder(builder: (context, constraints) {
          return _buildBody(constraints, blocContext, state);
        });
      },
      listener: (BuildContext context, LegalCertificatesPageState state) {
        if (state.status.isPosted) {
          widget.parentContext
              .read<LegalCertificatesPageBloc>()
              .add(LoadLegalCertificatesEvent());
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
      LegalCertificatesPageState state) {
    if (widget.parentContext
            .read<LegalCertificatesPageBloc>()
            .state
            .certificate !=
        null) {
      _titleController.text = widget.parentContext
              .read<LegalCertificatesPageBloc>()
              .state
              .certificate!
              .title ??
          "";
      _descriptionController.text = widget.parentContext
              .read<LegalCertificatesPageBloc>()
              .state
              .certificate!
              .description ??
          "";
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          const Center(
            child: Text(
              "Certificate Form",
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
                text: "Create certificate",
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
      BuildContext blocContext, LegalCertificatesPageState state) async {
    var legalCertificate = LegalCertificate.post(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      file: File(file!.path!),
    );

    context
        .read<LegalCertificatesPageBloc>()
        .add(LegalCertificatePostEvent(legalCertificate));
  }
}
