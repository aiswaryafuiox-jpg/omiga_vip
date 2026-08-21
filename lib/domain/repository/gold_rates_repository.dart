import '../../data/model/gold_rates_response_model.dart';

abstract class GoldRatesRepository {
  Future<GoldRatesResponseModel> getGoldRates(String userId, String password);
}
