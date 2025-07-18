import '../../domain/entities/qr_entity.dart';
import '../../domain/repositories/qr_repository.dart';

class QRRepositoryImpl implements QRRepository {
  @override
  Future<QREntity> generateQR(String type, Map<String, dynamic> data) async {
    // Mock QR generation - in real app this would create QR on server
    await Future.delayed(const Duration(milliseconds: 500));
    
    final qrData = {
      'type': type,
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'userId': 'user_123',
    };
    
    return QREntity(
      id: 'qr_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'user_123',
      type: type,
      data: qrData.toString(),
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(hours: 24)),
      isActive: true,
    );
  }

  @override
  Future<QREntity> scanQR(String qrData) async {
    // Mock QR scanning - in real app this would validate QR data
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Parse QR data (simplified)
    return QREntity(
      id: 'scanned_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'user_123',
      type: 'payment',
      data: qrData,
      createdAt: DateTime.now(),
      isActive: true,
    );
  }

  @override
  Future<List<QREntity>> getUserQRs() async {
    // Mock user QRs - in real app this would fetch from API
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      QREntity(
        id: 'qr_1',
        userId: 'user_123',
        type: 'profile',
        data: '{"type":"profile","userId":"user_123"}',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isActive: true,
      ),
      QREntity(
        id: 'qr_2',
        userId: 'user_123',
        type: 'payment',
        data: '{"type":"payment","amount":100,"currency":"BS"}',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        expiresAt: DateTime.now().add(const Duration(hours: 22)),
        isActive: true,
      ),
    ];
  }

  @override
  Future<void> deactivateQR(String qrId) async {
    // Mock deactivation - in real app this would update on server
    await Future.delayed(const Duration(milliseconds: 300));
  }
} 