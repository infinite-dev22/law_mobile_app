import '../../model/attorney.dart';
import '../definition/attorney_repo.dart';

class AttorneyRepoImpl extends AttorneyRepo {
  @override
  Future<List<Attorney>> getAllAttorneys(String authToken) async {
    // TODO: implement getAllAttorneys
    // throw UnimplementedError();
    List<Attorney> getAttorneys() {
      return [
        Attorney('DA-001', 'Admin', 'Demo Attorney 2',
            'Dirm Attorneys Attorney.pdf', 'Pending'),
        Attorney('DA-002', 'Admin', 'Demo Legal Attorney',
            'Dirm Attorneys Attorney.pdf', 'Pending'),
        Attorney('DA-003', 'Admin', 'Demo Legal Attorney',
            'Dirm Attorneys Attorney.pdf', 'Pending'),
        Attorney('DA-004', 'Admin', 'Demo Legal Attorney',
            'Dirm Attorneys Attorney.pdf', 'Pending'),
        Attorney('DA-005', 'Admin', 'Demo Legal Attorney',
            'Dirm Attorneys Attorney.pdf', 'Pending'),
      ];
    }

    return getAttorneys();
  }
}
