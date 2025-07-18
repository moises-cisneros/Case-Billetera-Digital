class QREntity {
  final String id;
  final String userId;
  final String type; // 'payment', 'profile', 'crypto'
  final String data;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final bool isActive;

  QREntity({
    required this.id,
    required this.userId,
    required this.type,
    required this.data,
    required this.createdAt,
    this.expiresAt,
    required this.isActive,
  });
} 