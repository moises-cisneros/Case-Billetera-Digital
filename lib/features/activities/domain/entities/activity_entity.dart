class ActivityEntity {
  final String id;
  final String type; // 'payment', 'transfer', 'deposit', 'withdrawal', 'crypto'
  final String title;
  final String description;
  final double amount;
  final String currency;
  final String status; // 'completed', 'pending', 'failed'
  final DateTime timestamp;
  final String? recipientId;
  final String? recipientName;
  final String? senderId;
  final String? senderName;
  final String? transactionHash;
  final Map<String, dynamic>? metadata;

  ActivityEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.amount,
    required this.currency,
    required this.status,
    required this.timestamp,
    this.recipientId,
    this.recipientName,
    this.senderId,
    this.senderName,
    this.transactionHash,
    this.metadata,
  });
} 