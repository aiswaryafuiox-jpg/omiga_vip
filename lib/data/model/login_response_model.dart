class LoginResponseModel {
  final bool success;
  final String message;
  final int code;
  final LoginData? data;

  LoginResponseModel({
    required this.success,
    required this.message,
    required this.code,
    this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      code: json['code'] ?? 0,
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }
}

class LoginData {
  final UserModel? user;

  LoginData({this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}

class UserModel {
  final int id;
  final String userId;
  final String pwdHint;
  final String refId;
  final String? refName;
  final String team;
  final int level;
  final String name;
  final String phoneNumber;
  final String email;
  final String? profileImg;
  final String pincode;
  final String address;
  final String state;
  final String country;
  final String selfInvest;
  final String teamInvest;
  final String selfPurchase;
  final String teamPurchase;
  final String credit;
  final String debit;
  final bool isActive;
  final int isActivatePurchase;
  final String entryDate;

  UserModel({
    required this.id,
    required this.userId,
    required this.pwdHint,
    required this.refId,
    this.refName,
    required this.team,
    required this.level,
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.profileImg,
    required this.pincode,
    required this.address,
    required this.state,
    required this.country,
    required this.selfInvest,
    required this.teamInvest,
    required this.selfPurchase,
    required this.teamPurchase,
    required this.credit,
    required this.debit,
    required this.isActive,
    required this.isActivatePurchase,
    required this.entryDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? '',
      pwdHint: json['pwd_hint'] ?? '',
      refId: json['ref_id'] ?? '',
      refName: json['ref_name'],
      team: json['team'] ?? '',
      level: json['level'] ?? 0,
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      profileImg: json['profile_img'],
      pincode: json['pincode'] ?? '',
      address: json['address'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      selfInvest: json['self_invest'] ?? '0.00',
      teamInvest: json['team_invest'] ?? '0.00',
      selfPurchase: json['self_purchase'] ?? '0.00',
      teamPurchase: json['team_purchase'] ?? '0.00',
      credit: json['credit'] ?? '0.00',
      debit: json['debit'] ?? '0.00',
      isActive: json['is_active'] ?? false,
      isActivatePurchase: json['is_activate_purchase'] ?? 0,
      entryDate: json['entry_date'] ?? '',
    );
  }
}
