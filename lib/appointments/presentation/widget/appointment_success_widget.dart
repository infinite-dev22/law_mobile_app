import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/appointment_page/appointments_page_bloc.dart';
import 'appointment_item_widget.dart';

class AppointmentSuccessWidget extends StatelessWidget {
  const AppointmentSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentsPageBloc, AppointmentsPageState>(
      builder: (context, state) {
        return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.appointments!.length,
            itemBuilder: (context, index) => Card(
                  color: Colors.white10.withOpacity(.2),
                  child: ListTile(
                    title: AppointmentItem(
                        data: state.appointments!.elementAt(index)),
                  ),
                ));
      },
      listener: (context, state) {},
    );
  }
}
