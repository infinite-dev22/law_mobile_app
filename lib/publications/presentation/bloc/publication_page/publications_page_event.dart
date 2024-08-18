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

class PublicationPostEvent extends PublicationsPageEvent {
  final Publication publication;

  const PublicationPostEvent(this.publication);

  @override
  List<Object?> get props => [publication];
}

class PublicationAddedEvent extends PublicationsPageEvent {}

class DeletePublicationEvent extends PublicationsPageEvent {
  final String slug;

  const DeletePublicationEvent(this.slug);

  @override
  List<Object?> get props => [slug];
}

class GetPublicationEvent extends PublicationsPageEvent {
  final String slug;
  final bool edit;

  const GetPublicationEvent(this.slug, this.edit);

  @override
  List<Object?> get props => [slug, edit];
}

class DownloadPublicationEvent extends PublicationsPageEvent {
  final String slug;

  const DownloadPublicationEvent(this.slug);

  @override
  List<Object?> get props => [slug];
}
