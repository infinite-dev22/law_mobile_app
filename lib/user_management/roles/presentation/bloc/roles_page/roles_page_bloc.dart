import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'roles_page_event.dart';
part 'roles_page_state.dart';

class RolesPageBloc extends Bloc<RolesPageEvent, RolesPageState> {
  RolesPageBloc() : super(RolesPageInitial()) {
    on<RolesPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
