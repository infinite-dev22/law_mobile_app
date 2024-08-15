import '../../model/publication.dart';

abstract class PublicationRepo {
  Future<List<Publication>> getAllPublications(String authToken);

  dynamic postPublication(String authToken, Publication data);

  dynamic deletePublication(String authToken, String slug);

  Future<Publication?> getPublication(String authToken, String slug);

  dynamic downloadPublication(String authToken, String slug);
}
