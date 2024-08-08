import 'package:dirm_attorneys_mobile/legal_certificates/presentation/widget/no_certificates_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Certificates"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.lighterColor,
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(FeatherIcons.plus),
        onPressed: () {
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
                child: const SingleChildScrollView(child: CertificatesForm()),
              ),
            ),
          );
        },
      ),
      body: BlocConsumer<LegalCertificatesPageBloc, LegalCertificatesPageState>(
        builder: (context, state) {
          if (state.status.isInitial) {
            context
                .read<LegalCertificatesPageBloc>()
                .add(LoadLegalCertificatesEvent());
          }
          if (state.status.isSuccess) {
            return const LegalCertificateSuccessWidget();
          }
          if (state.status.isLoading) {
            return const GlobalLoadingWidget();
          }
          if (state.status.isEmpty) {
            return const NoCertificatesWidget();
          }
          if (state.status.isNotFound) {
            return const NotFoundWidget();
          }
          if (state.status.isError) {
            return const GlobalErrorWidget();
          }
          return const NoCertificatesWidget();
        },
        listener: (context, state) {
          if (state.status.isInitial) {
            Toast.show("Initial State",
                duration: Toast.lengthShort, gravity: Toast.bottom);
          }
          if (state.status.isSuccess) {
            Toast.show("Success State",
                duration: Toast.lengthShort, gravity: Toast.bottom);
          }
          if (state.status.isLoading) {
            Toast.show("Loading State",
                duration: Toast.lengthShort, gravity: Toast.bottom);
          }
          if (state.status.isError) {
            Toast.show("Error State",
                duration: Toast.lengthShort, gravity: Toast.bottom);
          }
        },
      ),
    );
  }
}
