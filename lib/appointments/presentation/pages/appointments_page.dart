import 'package:dirm_attorneys_mobile/Global/Variables/colors.dart';
import 'package:dirm_attorneys_mobile/Global/Widgets/error_widget.dart';
import 'package:dirm_attorneys_mobile/Global/Widgets/loading_widget.dart';
import 'package:dirm_attorneys_mobile/appointments/presentation/bloc/appointment_page/appointments_page_bloc.dart';
import 'package:dirm_attorneys_mobile/appointments/presentation/forms/appointment_form.dart';
import 'package:dirm_attorneys_mobile/appointments/presentation/widget/appointment_success_widget.dart';
import 'package:dirm_attorneys_mobile/appointments/presentation/widget/no_appointments_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:toast/toast.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocConsumer<AppointmentsPageBloc, AppointmentsPageState>(
      builder: (blocContext, state) {
        if (state.status.isInitial) {
          blocContext.read<AppointmentsPageBloc>().add(LoadAppointmentsEvent());
        }
        if (state.status.isSuccess) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Appointments"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              floatingActionButton: _fab(blocContext, context),
              body: const AppointmentSuccessWidget());
        }
        if (state.status.isLoading) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Appointments"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              floatingActionButton: _fab(blocContext, context),
              body: const GlobalLoadingWidget());
        }
        if (state.status.isError) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Appointments"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              floatingActionButton: _fab(blocContext, context),
              body: const GlobalErrorWidget());
        }
        if (state.status.isEmpty) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Appointments"),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.lighterColor,
              ),
              floatingActionButton: _fab(blocContext, context),
              body: const NoAppointmentsWidget());
        }
        return Scaffold(
            appBar: AppBar(
              title: const Text("Appointments"),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.lighterColor,
            ),
            floatingActionButton: _fab(blocContext, context),
            body: const GlobalLoadingWidget());
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
    );
  }

  Widget _fab(BuildContext blocContext, BuildContext context) {
    return FloatingActionButton(
      child: const Icon(FeatherIcons.plus),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isDismissible: false,
          isScrollControlled: true,
          builder: (context) => AnimatedPadding(
            padding: const EdgeInsets.all(8.0).copyWith(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: BlocProvider(
              create: (context) => AppointmentsPageBloc(),
              child: SingleChildScrollView(
                child: AppointmentsForm(
                  parentContext: blocContext,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _displayCaseForm(BuildContext blocContext, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) => AnimatedPadding(
        padding: const EdgeInsets.all(8.0).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: BlocProvider(
          create: (context) => AppointmentsPageBloc(),
          child: AppointmentsForm(
            parentContext: blocContext,
          ),
        ),
      ),
    );
  }
}
