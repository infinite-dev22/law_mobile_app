import 'package:dirm_attorneys_mobile/Global/Variables/colors.dart';
import 'package:dirm_attorneys_mobile/Global/Widgets/error_widget.dart';
import 'package:dirm_attorneys_mobile/Global/Widgets/loading_widget.dart';
import 'package:dirm_attorneys_mobile/attorneys/presentation/bloc/attorney_page/attorneys_page_bloc.dart';
import 'package:dirm_attorneys_mobile/attorneys/presentation/widget/attorney_success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class AttorneysPage extends StatelessWidget {
  const AttorneysPage({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Attorneys"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.lighterColor,
      ),
      body: BlocConsumer<AttorneysPageBloc, AttorneysPageState>(
        builder: (context, state) {
          if (state.status.isInitial) {
            context.read<AttorneysPageBloc>().add(LoadAttorneysEvent());
          }
          if (state.status.isSuccess) {
            return const AttorneySuccessWidget();
          }
          if (state.status.isLoading) {
            return const GlobalLoadingWidget();
          }
          if (state.status.isError) {
            return const GlobalErrorWidget();
          }
          return const GlobalLoadingWidget();
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
      ),
    );
  }
}
