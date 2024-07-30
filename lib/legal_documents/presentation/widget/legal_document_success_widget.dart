import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/legal_documents_page/legal_documents_page_bloc.dart';
import 'legal_document_item_widget.dart';

class LegalDocumentSuccessWidget extends StatelessWidget {
  const LegalDocumentSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LegalDocumentsPageBloc, LegalDocumentsPageState>(
      builder: (context, state) {
        return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.documents!.length,
            itemBuilder: (context, index) => Card(
              color: Colors.white10.withOpacity(.2),
                  child: ListTile(
                    title: LegalDocumentItem(
                        data: state.documents!.elementAt(index)),
                  ),
                ));
      },
      listener: (context, state) {},
    );
  }
}
