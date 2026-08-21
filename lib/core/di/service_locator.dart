import 'package:get_it/get_it.dart';
import 'package:omiga_vip/data/repository/logout_repository_impl.dart';
import 'package:omiga_vip/domain/repository/logout_repository.dart';
import 'package:omiga_vip/domain/usecase/logout_usecase.dart';
import '../services/api_service.dart';
import '../../domain/repository/login_repository.dart';
import '../../data/repository/login_repository_impl.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/repository/gold_rates_repository.dart';
import '../../data/repository/gold_rates_repository_impl.dart';
import '../../domain/usecase/get_gold_rates_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Api Service
  sl.registerLazySingleton<ApiService>(() => ApiService());

  /// Login Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(sl<ApiService>()),
  );

  /// Login Usecase
  sl.registerLazySingleton(() => LoginUseCase(sl<LoginRepository>()));

  /// Logout Repository
  sl.registerLazySingleton<LogoutRepository>(
    () => LogoutRepositoryImpl(sl<ApiService>()),
  );

  /// Logout Usecase
  sl.registerLazySingleton(() => LogoutUseCase(sl<LogoutRepository>()));

}
