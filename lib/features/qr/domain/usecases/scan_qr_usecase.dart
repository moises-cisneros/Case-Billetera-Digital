import '../entities/qr_entity.dart';
import '../repositories/qr_repository.dart';

class ScanQRUseCase {
  final QRRepository repository;

  ScanQRUseCase(this.repository);

  Future<QREntity> call(String qrData) async {
    return await repository.scanQR(qrData);
  }
} 