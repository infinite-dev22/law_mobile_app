import '../../model/publication.dart';

abstract class PublicationRepo {
  Future<List<Publication>> getAllPublications(String authToken);
}
