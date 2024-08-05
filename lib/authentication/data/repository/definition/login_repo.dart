import 'package:dirm_attorneys_mobile/authentication/data/model/login_model.dart';

abstract class LoginRepo {
  dynamic postLogin(String authToken, LoginModel data);
}
