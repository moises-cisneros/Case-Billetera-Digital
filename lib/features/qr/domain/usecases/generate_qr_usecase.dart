import '../entities/qr_entity.dart';
import '../repositories/qr_repository.dart';

class GenerateQRUseCase {
  final QRRepository repository;

  GenerateQRUseCase(this.repository);

  Future<QREntity> call(String type, Map<String, dynamic> data) async {
    return await repository.generateQR(type, data);
  }
} 