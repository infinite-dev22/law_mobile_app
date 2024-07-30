import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/publication_page/publications_page_bloc.dart';
import 'publication_item_widget.dart';

class PublicationSuccessWidget extends StatelessWidget {
  const PublicationSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PublicationsPageBloc, PublicationsPageState>(
      builder: (context, state) {
        return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.publications!.length,
            itemBuilder: (context, index) => Card(
                  color: Colors.white10.withOpacity(.2),
                  child: ListTile(
                    title: PublicationItem(
                        data: state.publications!.elementAt(index)),
                  ),
                ));
      },
      listener: (context, state) {},
    );
  }
}
