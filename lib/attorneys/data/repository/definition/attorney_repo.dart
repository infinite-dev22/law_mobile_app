import '../../model/attorney.dart';

abstract class AttorneyRepo {
  Future<List<Attorney>> getAllAttorneys(String authToken);
}
