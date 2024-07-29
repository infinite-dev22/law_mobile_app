import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'legal_issues_pages_event.dart';
part 'legal_issues_pages_state.dart';

class LegalIssuesPagesBloc extends Bloc<LegalIssuesPagesEvent, LegalIssuesPagesState> {
  LegalIssuesPagesBloc() : super(LegalIssuesPagesInitial()) {
    on<LegalIssuesPagesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
