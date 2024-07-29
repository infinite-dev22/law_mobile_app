import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'legal_access_page_event.dart';
part 'legal_access_page_state.dart';

class LegalAccessPageBloc extends Bloc<LegalAccessPageEvent, LegalAccessPageState> {
  LegalAccessPageBloc() : super(LegalAccessPageInitial()) {
    on<LegalAccessPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
