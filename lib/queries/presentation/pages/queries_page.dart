import 'package:dirm_attorneys_mobile/Global/Variables/colors.dart';
import 'package:dirm_attorneys_mobile/Global/Widgets/error_widget.dart';
import 'package:dirm_attorneys_mobile/Global/Widgets/loading_widget.dart';
import 'package:dirm_attorneys_mobile/queries/presentation/bloc/appointment_page/queries_page_bloc.dart';
import 'package:dirm_attorneys_mobile/queries/presentation/widget/no_queries_widget.dart';
import 'package:dirm_attorneys_mobile/queries/presentation/widget/query_success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:toast/toast.dart';

class QueriesPage extends StatelessWidget {
  const QueriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Queries"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.lighterColor,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(FeatherIcons.plus),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const Center(
                child: Text("Query Form here"),
              );
            },
          );
        },
      ),
      body: BlocConsumer<QueriesPageBloc, QueriesPageState>(
        builder: (context, state) {
          if (state.status.isInitial) {
            context.read<QueriesPageBloc>().add(LoadQueriesEvent());
          }
          if (state.status.isSuccess) {
            return const QuerySuccessWidget();
          }
          if (state.status.isLoading) {
            return const GlobalLoadingWidget();
          }
          if (state.status.isError) {
            return const GlobalErrorWidget();
          }
          if (state.status.isEmpty) {
            return const NoQueriesWidget();
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
