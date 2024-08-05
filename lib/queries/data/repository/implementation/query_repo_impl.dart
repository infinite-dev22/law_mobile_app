import '../../model/query.dart';
import '../definition/query_repo.dart';

class QueryRepoImpl extends QueryRepo {
  @override
  Future<List<Query>> getAllQueries(String authToken) async {
    // TODO: implement getAllQueries
    // throw UnimplementedError();
    List<Query> getQueries() {
      return [
        Query('DA-001', 'Admin', 'Demo Query 2', 'Dirm Queries Query.pdf',
            'Pending'),
        Query('DA-002', 'Admin', 'Demo Legal Query', 'Dirm Queries Query.pdf',
            'Pending'),
        Query('DA-003', 'Admin', 'Demo Legal Query', 'Dirm Queries Query.pdf',
            'Pending'),
        Query('DA-004', 'Admin', 'Demo Legal Query', 'Dirm Queries Query.pdf',
            'Pending'),
        Query('DA-005', 'Admin', 'Demo Legal Query', 'Dirm Queries Query.pdf',
            'Pending'),
      ];
    }

    return getQueries();
  }
}
