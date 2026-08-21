import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';

class GoldRate {
  final String purity;
  final RxDouble price;
  final RxDouble change;
  final RxBool isUp;

  GoldRate({
    required this.purity,
    required double initialPrice,
    required double initialChange,
    required bool initialIsUp,
  })  : price = initialPrice.obs,
        change = initialChange.obs,
        isUp = initialIsUp.obs;
}

class DashboardController extends GetxController {
  final RxString username = 'novak.technology'.obs;
  final RxString userId = 'OM9728401032'.obs;
  final RxString email = 'novak.technology@gmail.com'.obs;
  final RxString memberRank = 'Member'.obs;

  final RxDouble myAdvance = 0.0.obs;
  final RxDouble myPurchase = 0.0.obs;

  final List<GoldRate> goldRates = [
    GoldRate(purity: '9K', initialPrice: 6052.00, initialChange: 2.25, initialIsUp: true),
    GoldRate(purity: '18K', initialPrice: 11945.00, initialChange: 2.25, initialIsUp: true),
    GoldRate(purity: '22K', initialPrice: 14600.00, initialChange: -2.25, initialIsUp: false),
  ];

  Timer? _timer;
  final _random = Random();

  @override
  void onInit() {
    super.onInit();
    fetchRates(); // Initial fetch on load
    _startPeriodicFetch();
  }

  void _startPeriodicFetch() {
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      fetchRates();
      
      // Simulate minor live index change percentage shifts
      for (var rate in goldRates) {
        double percentDiff = (_random.nextDouble() * 0.4) - 0.2;
        double currentPercent = rate.change.value * (rate.isUp.value ? 1 : -1);
        double newPercent = double.parse((currentPercent + percentDiff).toStringAsFixed(2));
        
        if (newPercent > 5.0) newPercent = 5.0;
        if (newPercent < -5.0) newPercent = -5.0;

        rate.change.value = newPercent.abs();
        rate.isUp.value = newPercent >= 0;
      }
    });
  }

  Future<void> fetchRates() async {
    try {
      final response = await GetConnect().get(
        'https://omigavip.com/api/get_gold_rates',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'x-api-key': 'jkjnhgtfrderfgthjwertyuijhfdscvbnvbnmjhg',
        },
      );
      if (response.status.isOk && response.body != null) {
        final data = response.body;
        if (data['success'] == true && data['data'] != null) {
          final ratesData = data['data'];
          final double? price9k = double.tryParse(ratesData['9k_price_per_gram']?.toString() ?? '');
          final double? price18k = double.tryParse(ratesData['18k_price_per_gram']?.toString() ?? '');
          final double? price22k = double.tryParse(ratesData['22k_price_per_gram']?.toString() ?? '');

          if (price9k != null) {
            goldRates[0].price.value = price9k;
          }
          if (price18k != null) {
            goldRates[1].price.value = price18k;
          }
          if (price22k != null) {
            goldRates[2].price.value = price22k;
          }
        }
      }
    } catch (e) {
      // Keep mock values / standard fallback on exception
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
