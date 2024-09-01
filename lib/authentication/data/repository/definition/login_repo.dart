import 'package:dirm_attorneys_mobile/authentication/data/model/login_model.dart';
import 'package:dirm_attorneys_mobile/authentication/data/model/signup_model.dart';

abstract class LoginRepo {
  dynamic postLogin(LoginModel data);

  dynamic postSignUp(SignUpModel data);
}
