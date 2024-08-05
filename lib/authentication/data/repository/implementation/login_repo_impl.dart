import '../../model/login_model.dart';
import '../../request/login_requests.dart';
import '../definition/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  @override
  Future<dynamic> postLogin(LoginModel data) async {
    return LoginRequests.postLogin(data.toJson());
  }
}
