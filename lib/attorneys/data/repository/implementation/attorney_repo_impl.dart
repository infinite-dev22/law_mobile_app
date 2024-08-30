import 'package:dio/dio.dart';

import '../../../../Global/data/model/global_response_model.dart';
import '../../model/attorney.dart';
import '../../request/attorney_requests.dart';
import '../definition/attorney_repo.dart';

class AttorneyRepoImpl extends AttorneyRepo {
  @override
  Future<List<Attorney>> getAllAttorneys(String authToken) async {
    List<Attorney> legalIssues = List.empty(growable: true);
    await AttorneyRequests.getAttorneys(authToken)
        .then((value) => legalIssues = value)
        .onError(
          (error, stackTrace) => throw Exception(error),
    );
    return legalIssues;
  }

  @override
  Future<Attorney?> getAttorney(String authToken, String slug) async {
    late Attorney? response;

    await AttorneyRequests.getAttorney(authToken, slug).then((value) {
      response = value;
    }).onError(
          (error, stackTrace) => throw Exception(error),
    );
    return response;
  }
}
