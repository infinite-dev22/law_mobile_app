part of 'attorneys_page_bloc.dart';

sealed class AttorneysPageEvent extends Equatable {
  const AttorneysPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadAttorneysEvent extends AttorneysPageEvent {}

class RefreshAttorneysEvent extends AttorneysPageEvent {}

class LoadSingleAttorneyEvent extends AttorneysPageEvent {
  final int id;

  const LoadSingleAttorneyEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AttorneyAddedEvent extends AttorneysPageEvent {}
