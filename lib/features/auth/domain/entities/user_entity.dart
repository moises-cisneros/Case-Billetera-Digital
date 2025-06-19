import 'package:equatable/equatable.dart';
import 'package:case_digital_wallet/features/auth/data/models/auth_models.dart';

class UserEntity extends Equatable {
  final String id;
  final String phoneNumber;
  final String status;
  final String kycLevel;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.phoneNumber,
    required this.status,
    required this.kycLevel,
    required this.createdAt,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    final user = User.fromJson(json);
    return UserEntity(
      id: user.id,
      phoneNumber: user.phoneNumber,
      status: user.status,
      kycLevel: user.kycLevel,
      createdAt: user.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return User(
      id: id,
      phoneNumber: phoneNumber,
      status: status,
      kycLevel: kycLevel,
      createdAt: createdAt,
    ).toJson();
  }

  @override
  List<Object?> get props => [id, phoneNumber, status, kycLevel, createdAt];
}
