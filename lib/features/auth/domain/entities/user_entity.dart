import 'package:equatable/equatable.dart';
import 'package:case_digital_wallet/features/auth/data/models/auth_models.dart';

class UserEntity extends Equatable {
  final String id;
  final String phoneNumber;
  final String status;
  final String kycLevel;
  final DateTime createdAt;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  const UserEntity({
    required this.id,
    required this.phoneNumber,
    required this.status,
    required this.kycLevel,
    required this.createdAt,
    this.email,
    this.displayName,
    this.photoUrl,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    final user = User.fromJson(json);
    return UserEntity(
      id: user.id,
      phoneNumber: user.phoneNumber,
      status: user.status,
      kycLevel: user.kycLevel,
      createdAt: user.createdAt,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return User(
      id: id,
      phoneNumber: phoneNumber,
      status: status,
      kycLevel: kycLevel,
      createdAt: createdAt,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    ).toJson();
  }

  @override
  List<Object?> get props => [
        id,
        phoneNumber,
        status,
        kycLevel,
        createdAt,
        email,
        displayName,
        photoUrl
      ];
}
