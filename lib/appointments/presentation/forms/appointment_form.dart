import 'package:dirm_attorneys_mobile/Global/Widgets/loading_button.dart';
import 'package:dirm_attorneys_mobile/Global/Widgets/mwigo_dropdown.dart';
import 'package:dirm_attorneys_mobile/Global/Widgets/mwigo_text_area.dart';
import 'package:dirm_attorneys_mobile/Global/Widgets/mwigo_text_field.dart';
import 'package:dirm_attorneys_mobile/Global/Widgets/mwigo_time_picker.dart';
import 'package:dirm_attorneys_mobile/appointments/data/model/appointment.dart';
import 'package:dirm_attorneys_mobile/appointments/data/model/attorney_availability.dart';
import 'package:dirm_attorneys_mobile/appointments/presentation/bloc/appointment_page/appointments_page_bloc.dart';
import 'package:dirm_attorneys_mobile/attorneys/data/model/attorney.dart';
import 'package:dirm_attorneys_mobile/attorneys/presentation/bloc/attorney_page/attorneys_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toast/toast.dart';

class AppointmentsForm extends StatefulWidget {
  final BuildContext parentContext;

  const AppointmentsForm({
    super.key,
    required this.parentContext,
  });

  @override
  State<AppointmentsForm> createState() => _AppointmentsFormState();
}

class _AppointmentsFormState extends State<AppointmentsForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isUpdate = false;
  String? slug;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  late int attorneyId;
  late int availabilityId;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocConsumer<AppointmentsPageBloc, AppointmentsPageState>(
      builder: (blocContext, masterState) {
        return LayoutBuilder(builder: (context, constraints) {
          return _buildBody(constraints, blocContext, masterState);
        });
      },
      listener: (BuildContext context, AppointmentsPageState masterState) {
        if (masterState.status.isPostSuccess) {
          widget.parentContext
              .read<AppointmentsPageBloc>()
              .add(LoadAppointmentsEvent());
          GoRouter.of(context).pop();
        }
        if (masterState.status.isPostError) {
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
      AppointmentsPageState masterState) {
    if (widget.parentContext.read<AppointmentsPageBloc>().state.appointment !=
        null) {
      isUpdate = true;
      _titleController.text = widget.parentContext
              .read<AppointmentsPageBloc>()
              .state
              .appointment!
              .title ??
          "";
      availabilityId = (widget.parentContext
              .read<AppointmentsPageBloc>()
              .state
              .appointment!
              .attorneyId ??
          0);
      attorneyId = widget.parentContext
              .read<AppointmentsPageBloc>()
              .state
              .appointment!
              .attorneyId ??
          0;
      _venueController.text = widget.parentContext
              .read<AppointmentsPageBloc>()
              .state
              .appointment!
              .venue ??
          "";
      _startTimeController.text = widget.parentContext
              .read<AppointmentsPageBloc>()
              .state
              .appointment!
              .appointmentTime ??
          "";
      _endTimeController.text = widget.parentContext
              .read<AppointmentsPageBloc>()
              .state
              .appointment!
              .appointmentEndTime ??
          "";
      _commentController.text = widget.parentContext
              .read<AppointmentsPageBloc>()
              .state
              .appointment!
              .comment ??
          "";
      slug = widget.parentContext
          .read<AppointmentsPageBloc>()
          .state
          .appointment!
          .slug;
    }

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: Text(
              "Appointment Form",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 8.0),
          MwigoTextField(
            label: "Title",
            controller: _titleController,
            disabled: masterState.status.isPostLoading,
          ),
          const SizedBox(height: 8),
          BlocConsumer<AttorneysPageBloc, AttorneysPageState>(
            listener: (blocContext, attorneyState) {
              if (attorneyState.status.isInitial) {
                blocContext.read<AttorneysPageBloc>().add(LoadAttorneysEvent());
              }
            },
            builder: (blocContext, attorneyState) {
              if (attorneyState.status.isInitial) {
                blocContext.read<AttorneysPageBloc>().add(LoadAttorneysEvent());
              }
              return MwigoDropdown<Attorney>(
                label: "Attorney",
                disabled: masterState.status.isPostLoading,
                menuItems: attorneyState.attorneys ?? [],
                onChanged: (value) {
                  blocContext
                      .read<AppointmentsPageBloc>()
                      .add(LoadAttorneyAvailabilityEvent(value!.id!));
                  attorneyId = value.id!;
                },
              );
            },
          ),
          MwigoDropdown<AttorneyAvailability>(
            label: "\Availability",
            disabled: masterState.status.isPostLoading,
            menuItems: masterState.attorneyAvailability ?? [],
            onChanged: (value) {
              availabilityId = value!.id!;
            },
          ),
          MwigoTextField(
            label: "Venue",
            controller: _venueController,
            disabled: masterState.status.isPostLoading,
          ),
          const SizedBox(height: 8),
          MwigoTimePicker(
            label: "Start Time",
            controller: _startTimeController,
          ),
          const SizedBox(height: 8),
          MwigoTimePicker(
            label: "Ends At",
            controller: _endTimeController,
          ),
          const SizedBox(height: 8),
          MwigoTextArea(
            label: "Comment",
            controller: _commentController,
            disabled: masterState.status.isPostLoading,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoadingButton(
                width: constraints.maxWidth * .3,
                text: "Cancel",
                outlined: true,
                disabled: masterState.status.isPostLoading,
                onTap: () {
                  GoRouter.of(context).pop();
                },
              ),
              LoadingButton(
                width: constraints.maxWidth * .6,
                text: "Create appointment",
                busy: masterState.status.isPostLoading,
                onTap: () {
                  _submitForm(blocContext, masterState);
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
      BuildContext blocContext, AppointmentsPageState masterState) async {
    var appointment = Appointment.post(
      title: _titleController.text,
      availabilityId: availabilityId,
      attorneyId: attorneyId,
      venue: _venueController.text,
      appointmentTime: _startTimeController.text,
      appointmentEndTime: _endTimeController.text,
      comment: _commentController.text,
    );

    context.read<AppointmentsPageBloc>().add((isUpdate == true)
        ? UpdateAppointmentEvent(appointment)
        : AddAppointmentEvent(appointment));
  }
}
