import '../../data/model/gold_rates_response_model.dart';
import '../repository/gold_rates_repository.dart';

class GetGoldRatesUseCase {
  final GoldRatesRepository _repository;

  GetGoldRatesUseCase(this._repository);

  Future<GoldRatesResponseModel> execute(String userId, String password) {
    return _repository.getGoldRates(userId, password);
  }
}
