import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/qr_entity.dart';
import '../../domain/usecases/generate_qr_usecase.dart';
import '../../domain/usecases/scan_qr_usecase.dart';

// Events
abstract class QREvent {}

class GenerateQREvent extends QREvent {
  final String type;
  final Map<String, dynamic> data;
  GenerateQREvent({required this.type, required this.data});
}

class ScanQREvent extends QREvent {
  final String qrData;
  ScanQREvent(this.qrData);
}

class LoadUserQREvent extends QREvent {}

// States
abstract class QRState {}

class QRInitial extends QRState {}

class QRLoading extends QRState {}

class QRGenerated extends QRState {
  final QREntity qr;
  QRGenerated(this.qr);
}

class QRScanned extends QRState {
  final QREntity qr;
  QRScanned(this.qr);
}

class UserQRsLoaded extends QRState {
  final List<QREntity> qrs;
  UserQRsLoaded(this.qrs);
}

class QRError extends QRState {
  final String message;
  QRError(this.message);
}

// Bloc
class QRBloc extends Bloc<QREvent, QRState> {
  final GenerateQRUseCase generateQRUseCase;
  final ScanQRUseCase scanQRUseCase;

  QRBloc({
    required this.generateQRUseCase,
    required this.scanQRUseCase,
  }) : super(QRInitial()) {
    on<GenerateQREvent>(_onGenerateQR);
    on<ScanQREvent>(_onScanQR);
    on<LoadUserQREvent>(_onLoadUserQRs);
  }

  Future<void> _onGenerateQR(
    GenerateQREvent event,
    Emitter<QRState> emit,
  ) async {
    emit(QRLoading());
    try {
      final qr = await generateQRUseCase(event.type, event.data);
      emit(QRGenerated(qr));
    } catch (e) {
      emit(QRError(e.toString()));
    }
  }

  Future<void> _onScanQR(
    ScanQREvent event,
    Emitter<QRState> emit,
  ) async {
    emit(QRLoading());
    try {
      final qr = await scanQRUseCase(event.qrData);
      emit(QRScanned(qr));
    } catch (e) {
      emit(QRError(e.toString()));
    }
  }

  Future<void> _onLoadUserQRs(
    LoadUserQREvent event,
    Emitter<QRState> emit,
  ) async {
    emit(QRLoading());
    try {
      // This would typically use a separate use case
      // For now, we'll generate mock data
      await Future.delayed(const Duration(milliseconds: 500));
      
      final qrs = [
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
      
      emit(UserQRsLoaded(qrs));
    } catch (e) {
      emit(QRError(e.toString()));
    }
  }
} 