import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'legal_documents_page_event.dart';
part 'legal_documents_page_state.dart';

class LegalDocumentsPageBloc extends Bloc<LegalDocumentsPageEvent, LegalDocumentsPageState> {
  LegalDocumentsPageBloc() : super(LegalDocumentsPageInitial()) {
    on<LegalDocumentsPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
