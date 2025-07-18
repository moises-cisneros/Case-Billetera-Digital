class UserProfileEntity {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final String? documentNumber;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime? lastLogin;

  UserProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
    this.documentNumber,
    required this.isVerified,
    required this.createdAt,
    this.lastLogin,
  });
} 