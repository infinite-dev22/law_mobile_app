import 'package:dio/dio.dart';

import '../../../../Global/data/model/global_response_model.dart';
import '../../model/legal_document.dart';
import '../../request/legal_document_requests.dart';
import '../definition/legal_document_repo.dart';

class LegalDocumentRepoImpl extends LegalDocumentRepo {
  @override
  Future<List<LegalDocument>> getAllLegalDocuments(String authToken) async {
    List<LegalDocument> legalDocuments = List.empty(growable: true);
    LegalDocumentRequests.getLegalDocuments(authToken)
        .then((value) => legalDocuments = value)
        .onError(
          (error, stackTrace) => throw Exception(error),
        );
    return legalDocuments;
  }

  @override
  Future<GlobalResponseModel?> postLegalDocument(
      String authToken, LegalDocument data) async {
    GlobalResponseModel? response;

    FormData formData = FormData.fromMap({
      "title": data.title,
      "file": await MultipartFile.fromFile(data.file!.path,
          filename: data.file!.path.split('/').last),
    });

    LegalDocumentRequests.postLegalDocument(authToken, formData).then((value) {
      response = value;
    }).onError(
      (error, stackTrace) {
        response = GlobalResponseModel.fromJson(const {
          "status": true,
          "message": "An error occurred whilst adding an document.",
          "data": 0
        });
        throw Exception(error);
      },
    );
    return response;
  }
}
