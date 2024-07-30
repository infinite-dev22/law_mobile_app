import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/legal_issues_page/legal_issues_pages_bloc.dart';
import 'legal_issue_item_widget.dart';

class LegalIssueSuccessWidget extends StatelessWidget {
  const LegalIssueSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LegalIssuesPagesBloc, LegalIssuesPageState>(
      builder: (context, state) {
        return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.issues!.length,
            itemBuilder: (context, index) => Card(
              color: Colors.white10.withOpacity(.2),
                  child: ListTile(
                    title: LegalIssueItem(data: state.issues!.elementAt(index)),
                  ),
                ));
      },
      listener: (context, state) {},
    );
  }
}
