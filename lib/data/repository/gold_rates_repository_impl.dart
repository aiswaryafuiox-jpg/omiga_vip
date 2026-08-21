import 'package:dio/dio.dart';
import '../../core/services/api_service.dart';
import '../../core/const/api_routes.dart';
import '../../domain/repository/gold_rates_repository.dart';
import '../model/gold_rates_response_model.dart';

class GoldRatesRepositoryImpl implements GoldRatesRepository {
  final ApiService _apiService;

  GoldRatesRepositoryImpl(this._apiService);

  @override
  Future<GoldRatesResponseModel> getGoldRates(String userId, String password) async {
    final formData = FormData.fromMap({
      'user_id': userId,
      'password': password,
    });

    final responseMap = await _apiService.get(
      ApiRoutes.goldRates,
      data: formData,
    );

    return GoldRatesResponseModel.fromJson(responseMap);
  }
}
