import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/attorney_page/attorneys_page_bloc.dart';
import 'attorney_item_widget.dart';

class AttorneySuccessWidget extends StatelessWidget {
  const AttorneySuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttorneysPageBloc, AttorneysPageState>(
      builder: (context, state) {
        return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.attorneys!.length,
            itemBuilder: (context, index) => Card(
                  color: Colors.white10.withOpacity(.2),
                  child: ListTile(
                    title: AttorneyItem(
                        data: state.attorneys!.elementAt(index)),
                  ),
                ));
      },
      listener: (context, state) {},
    );
  }
}
