import 'package:dio/dio.dart';

import '../../model/login_model.dart';
import '../../request/login_requests.dart';
import '../definition/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  @override
  Future<dynamic> postLogin(String authToken, LoginModel data) async {
    var logins = List.empty(growable: true);

    LoginRequests.postLogin(authToken, data.toJson())
        .then((value) => logins = value);
    return logins;
  }
}
