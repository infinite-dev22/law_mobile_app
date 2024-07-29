import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'legal_certificates_page_event.dart';
part 'legal_certificates_page_state.dart';

class LegalCertificatesPageBloc extends Bloc<LegalCertificatesPageEvent, LegalCertificatesPageState> {
  LegalCertificatesPageBloc() : super(LegalCertificatesPageInitial()) {
    on<LegalCertificatesPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
