import 'package:equatable/equatable.dart';

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

  @override
  List<Object?> get props => [id, phoneNumber, status, kycLevel, createdAt];
}