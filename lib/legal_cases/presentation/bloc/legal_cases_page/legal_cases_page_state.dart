part of 'legal_cases_page_bloc.dart';

enum LegalCasesPageStatus {
  initial,
  success,
  loading,
  error,
  notFound,
  empty,
}

extension LegalCasesPageStatusX on LegalCasesPageStatus {
  bool get isInitial => this == LegalCasesPageStatus.initial;

  bool get isSuccess => this == LegalCasesPageStatus.success;

  bool get isLoading => this == LegalCasesPageStatus.loading;

  bool get isError => this == LegalCasesPageStatus.error;

  bool get isNotFound => this == LegalCasesPageStatus.notFound;

  bool get isEmpty => this == LegalCasesPageStatus.empty;
}

@immutable
class LegalCasesPageState extends Equatable {
  final List<LegalCase>? legalCases;
  final LegalCasesPageStatus status;
  final LegalCase? legalCase;

  const LegalCasesPageState({
    this.legalCases,
    this.status = LegalCasesPageStatus.initial,
    this.legalCase,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    legalCases,
    status,
    legalCase,
  ];

  LegalCasesPageState copyWith({
    List<LegalCase>? legalCases,
    LegalCasesPageStatus? status,
    LegalCase? legalCase,
    bool? isLegalCaseLoading,
    String? message,
  }) {
    return LegalCasesPageState(
      legalCases: legalCases ?? this.legalCases,
      status: status ?? this.status,
      legalCase: legalCase ?? this.legalCase,
    );
  }
}