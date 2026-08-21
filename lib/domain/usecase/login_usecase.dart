import '../../data/model/login_response_model.dart';
import '../repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository _repository;

  LoginUseCase(this._repository);

  Future<LoginResponseModel> execute(String userId, String password) {
    return _repository.login(userId, password);
  }
}
