import '../../model/query.dart';

abstract class QueryRepo {
  Future<List<Query>> getAllQueries(String authToken);
}
