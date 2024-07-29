import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_page_event.dart';
part 'settings_page_state.dart';

class SettingsPageBloc extends Bloc<SettingsPageEvent, SettingsPageState> {
  SettingsPageBloc() : super(SettingsPageInitial()) {
    on<SettingsPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
