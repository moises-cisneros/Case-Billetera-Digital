import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ScannerEvent extends Equatable {
  const ScannerEvent();

  @override
  List<Object> get props => [];
}

class ScanQRRequested extends ScannerEvent {
  final String qrData;

  const ScanQRRequested(this.qrData);

  @override
  List<Object> get props => [qrData];
}

class ToggleTorchRequested extends ScannerEvent {}

// States
abstract class ScannerState extends Equatable {
  const ScannerState();

  @override
  List<Object?> get props => [];
}

class ScannerInitial extends ScannerState {}

class ScannerProcessing extends ScannerState {}

class ScannerSuccess extends ScannerState {
  final String qrData;

  const ScannerSuccess(this.qrData);

  @override
  List<Object> get props => [qrData];
}

class ScannerError extends ScannerState {
  final String message;

  const ScannerError(this.message);

  @override
  List<Object> get props => [message];
}

class TorchStateChanged extends ScannerState {
  final bool isOn;

  const TorchStateChanged(this.isOn);

  @override
  List<Object> get props => [isOn];
}

// Bloc
class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  bool _isTorchOn = false;

  ScannerBloc() : super(ScannerInitial()) {
    on<ScanQRRequested>(_onScanQRRequested);
    on<ToggleTorchRequested>(_onToggleTorchRequested);
  }

  Future<void> _onScanQRRequested(
    ScanQRRequested event,
    Emitter<ScannerState> emit,
  ) async {
    emit(ScannerProcessing());
    try {
      // Aquí podríamos validar el QR o hacer algún procesamiento adicional
      emit(ScannerSuccess(event.qrData));
    } catch (e) {
      emit(ScannerError(e.toString()));
    }
  }

  Future<void> _onToggleTorchRequested(
    ToggleTorchRequested event,
    Emitter<ScannerState> emit,
  ) async {
    _isTorchOn = !_isTorchOn;
    emit(TorchStateChanged(_isTorchOn));
  }
}
