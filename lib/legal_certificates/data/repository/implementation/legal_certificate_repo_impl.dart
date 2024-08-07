import 'package:dio/dio.dart';

import '../../../../Global/data/model/global_response_model.dart';
import '../../model/legal_certificate.dart';
import '../../request/legal_certificate_requests.dart';
import '../definition/legal_certificate_repo.dart';

class LegalCertificateRepoImpl extends LegalCertificateRepo {
  @override
  Future<List<LegalCertificate>> getAllLegalCertificates(
      String authToken) async {
    List<LegalCertificate> legalCertificates = List.empty(growable: true);

    await LegalCertificateRequests.getLegalCertificates(authToken)
        .then((value) => legalCertificates = value);
    return legalCertificates;
  }

  @override
  Future<GlobalResponseModel?> postLegalCertificate(
      String authToken, LegalCertificate data) async {
    GlobalResponseModel? response;

    FormData formData = FormData.fromMap({
      "title": data.title,
      "description": data.description,
      "file": await MultipartFile.fromFile(data.file!.path,
          filename: data.file!.path.split('/').last),
    });

    await LegalCertificateRequests.postLegalCertificate(authToken, formData)
        .then((value) {
      response = value;
    }).onError(
      (error, stackTrace) {
        response = GlobalResponseModel.fromJson(const {
          "status": true,
          "message": "An error occurred whilst adding an issue.",
          "data": 0
        });
        throw Exception(error);
      },
    );
    return response;
  }
}
