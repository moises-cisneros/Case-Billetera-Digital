import '../entities/qr_entity.dart';

abstract class QRRepository {
  Future<QREntity> generateQR(String type, Map<String, dynamic> data);
  Future<QREntity> scanQR(String qrData);
  Future<List<QREntity>> getUserQRs();
  Future<void> deactivateQR(String qrId);
} 