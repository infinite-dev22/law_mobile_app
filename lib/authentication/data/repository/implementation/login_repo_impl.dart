import 'package:dirm_attorneys_mobile/authentication/data/model/signup_model.dart';

import '../../model/login_model.dart';
import '../../request/login_requests.dart';
import '../definition/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  @override
  Future<dynamic> postLogin(LoginModel data) async {
    return LoginRequests.postLogin(data.toJson());
  }

  @override
  Future<dynamic> postSignUp(SignUpModel data) {
    return LoginRequests.postSignUp(data.toJson());
  }
}
