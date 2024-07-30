import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/legal_cases_page/legal_cases_page_bloc.dart';
import 'legal_case_item_widget.dart';

class LegalCaseSuccessWidget extends StatelessWidget {
  const LegalCaseSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LegalCasesPageBloc, LegalCasesPageState>(
      builder: (context, state) {
        return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.legalCases!.length,
            itemBuilder: (context, index) => Card(
                  color: Colors.white10.withOpacity(.2),
                  child: ListTile(
                    title:
                        LegalCaseItem(data: state.legalCases!.elementAt(index)),
                  ),
                ));
      },
      listener: (context, state) {},
    );
  }
}
