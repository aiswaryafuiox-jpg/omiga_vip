import '../../data/model/login_response_model.dart';

abstract class LoginRepository {
  Future<LoginResponseModel> login(String userId, String password);
}
