import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dirm_attorneys_mobile/queries/presentation/bloc/appointment_page/queries_page_bloc.dart';
import 'query_item_widget.dart';

class QuerySuccessWidget extends StatelessWidget {
  const QuerySuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QueriesPageBloc, QueriesPageState>(
      builder: (context, state) {
        return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.queries!.length,
            itemBuilder: (context, index) => Card(
                  color: Colors.white10.withOpacity(.2),
                  child: ListTile(
                    title: QueryItem(
                        data: state.queries!.elementAt(index)),
                  ),
                ));
      },
      listener: (context, state) {},
    );
  }
}
