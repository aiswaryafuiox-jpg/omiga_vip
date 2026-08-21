class GoldRatesResponseModel {
  final bool success;
  final String message;
  final int code;
  final GoldRatesData? data;

  GoldRatesResponseModel({
    required this.success,
    required this.message,
    required this.code,
    this.data,
  });

  factory GoldRatesResponseModel.fromJson(Map<String, dynamic> json) {
    return GoldRatesResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      code: json['code'] ?? 0,
      data: json['data'] != null ? GoldRatesData.fromJson(json['data']) : null,
    );
  }
}

class GoldRatesData {
  final String price9k;
  final String price18k;
  final String price22k;

  GoldRatesData({
    required this.price9k,
    required this.price18k,
    required this.price22k,
  });

  factory GoldRatesData.fromJson(Map<String, dynamic> json) {
    return GoldRatesData(
      price9k: json['9k_price_per_gram']?.toString() ?? '0.00',
      price18k: json['18k_price_per_gram']?.toString() ?? '0.00',
      price22k: json['22k_price_per_gram']?.toString() ?? '0.00',
    );
  }
}
