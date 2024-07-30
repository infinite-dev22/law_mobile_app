import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/legal_certificates_page/legal_certificates_page_bloc.dart';
import 'legal_certificate_item_widget.dart';

class LegalCertificateSuccessWidget extends StatelessWidget {
  const LegalCertificateSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LegalCertificatesPageBloc, LegalCertificatesPageState>(
      builder: (context, state) {
        return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.certificates!.length,
            itemBuilder: (context, index) => Card(
              color: Colors.white10.withOpacity(.2),
                  child: ListTile(
                    title: LegalCertificateItem(
                        data: state.certificates!.elementAt(index)),
                  ),
                ));
      },
      listener: (context, state) {},
    );
  }
}
