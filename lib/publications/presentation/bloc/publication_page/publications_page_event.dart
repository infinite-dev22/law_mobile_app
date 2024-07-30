part of 'publications_page_bloc.dart';

sealed class PublicationsPageEvent extends Equatable {
  const PublicationsPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadPublicationsEvent extends PublicationsPageEvent {}

class RefreshPublicationsEvent extends PublicationsPageEvent {}

class LoadSinglePublicationEvent extends PublicationsPageEvent {
  final int id;

  const LoadSinglePublicationEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class PublicationAddedEvent extends PublicationsPageEvent {}
