import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'users_page_event.dart';
part 'users_page_state.dart';

class UsersPageBloc extends Bloc<UsersPageEvent, UsersPageState> {
  UsersPageBloc() : super(UsersPageInitial()) {
    on<UsersPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
