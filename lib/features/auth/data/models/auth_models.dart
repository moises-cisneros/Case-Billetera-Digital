import 'package:json_annotation/json_annotation.dart';

part 'auth_models.g.dart';

@JsonSerializable()
class RequestSmsRequest {
  final String phoneNumber;

  RequestSmsRequest({required this.phoneNumber});

  factory RequestSmsRequest.fromJson(Map<String, dynamic> json) =>
      _$RequestSmsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestSmsRequestToJson(this);
}

@JsonSerializable()
class VerifySmsRequest {
  final String phoneNumber;
  final String otpCode;

  VerifySmsRequest({
    required this.phoneNumber,
    required this.otpCode,
  });

  factory VerifySmsRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifySmsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifySmsRequestToJson(this);
}

@JsonSerializable()
class CompleteRegistrationRequest {
  final String phoneNumber;
  final String password;
  final String pin;

  CompleteRegistrationRequest({
    required this.phoneNumber,
    required this.password,
    required this.pin,
  });

  factory CompleteRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$CompleteRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CompleteRegistrationRequestToJson(this);
}

@JsonSerializable()
class LoginRequest {
  final String phoneNumber;
  final String password;

  LoginRequest({
    required this.phoneNumber,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class AuthResponse {
  final String token;
  final User user;

  AuthResponse({
    required this.token,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class User {
  final String id;
  final String phoneNumber;
  final String status;
  final String kycLevel;
  final DateTime createdAt;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  User({
    required this.id,
    required this.phoneNumber,
    required this.status,
    required this.kycLevel,
    required this.createdAt,
    this.email,
    this.displayName,
    this.photoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class WalletGenerateResponse {
  final List<String> mnemonic;
  final String walletAddress;

  WalletGenerateResponse({
    required this.mnemonic,
    required this.walletAddress,
  });

  factory WalletGenerateResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletGenerateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletGenerateResponseToJson(this);
}

@JsonSerializable()
class UserBlockchainRegisterResponse {
  final String status;
  final String walletAddress;

  UserBlockchainRegisterResponse({
    required this.status,
    required this.walletAddress,
  });

  factory UserBlockchainRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$UserBlockchainRegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserBlockchainRegisterResponseToJson(this);
}
