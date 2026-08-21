import '../../data/repository/logout_repository_impl.dart';
import '../../domain/repository/logout_repository.dart';

class LogoutUseCase {
  final LogoutRepository _repository;

  LogoutUseCase(this._repository);

  Future<void> execute() async {
    await _repository.logout();
  }
}
