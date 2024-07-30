import '../../model/publication.dart';
import '../definition/publication_repo.dart';

class PublicationRepoImpl extends PublicationRepo {
  @override
  Future<List<Publication>> getAllPublications(String authToken) async {
    // TODO: implement getAllPublications
    // throw UnimplementedError();
    List<Publication> getPublications() {
      return [
        Publication('DA-001', 'Admin', 'Demo Publication 2', 'Dirm Attorneys Publication.pdf',
            'Pending'),
        Publication('DA-002', 'Admin', 'Demo Legal Publication',
            'Dirm Attorneys Publication.pdf', 'Pending'),
        Publication('DA-003', 'Admin', 'Demo Legal Publication',
            'Dirm Attorneys Publication.pdf', 'Pending'),
        Publication('DA-004', 'Admin', 'Demo Legal Publication',
            'Dirm Attorneys Publication.pdf', 'Pending'),
        Publication('DA-005', 'Admin', 'Demo Legal Publication',
            'Dirm Attorneys Publication.pdf', 'Pending'),
      ];
    }

    return getPublications();
  }
}
