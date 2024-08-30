import 'package:dirm_attorneys_mobile/queries/data/model/query.dart';

abstract class QueryRepo {
  Future<List<Query>> getAllQueries(String authToken);

  dynamic postQuery(String authToken, Query data);

  dynamic putQuery(String authToken, Query data);

  dynamic deleteQuery(String authToken, int queryId);

  Future<Query?> getQuery(String authToken, int queryId);
}
