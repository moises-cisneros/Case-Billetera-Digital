import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';
import '../bloc/qr_bloc.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  MobileScannerController? _scannerController;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController();
  }

  @override
  void dispose() {
    _scannerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showQRHistory(context),
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: BlocListener<QRBloc, QRState>(
        listener: (context, state) {
          if (state is QRScanned) {
            _handleScannedQR(state.qr);
          } else if (state is QRError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: Column(
          children: [
            Expanded(
              child: _buildScannerView(),
            ),
            _buildScannerControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildScannerView() {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryColor, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // Real camera view using mobile_scanner
            MobileScanner(
              controller: _scannerController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  if (barcode.rawValue != null) {
                    _handleScannedCode(barcode.rawValue!);
                  }
                }
              },
            ),
            // Scanner overlay
            _buildScannerOverlay(),
          ],
        ),
      ),
    );
  }

  void _handleScannedCode(String code) {
    if (!_isScanning) return;
    
    setState(() => _isScanning = false);
    _scannerController?.stop();
    
    // Procesar el código QR
    context.read<QRBloc>().add(ScanQREvent(code));
  }

  void _handleScannedQR(dynamic qr) {
    // Show QR result dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('QR Escaneado'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tipo: ${_getQRTypeTitle(qr.type)}'),
            const SizedBox(height: 8),
            Text('Datos: ${qr.data}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _processQR(qr);
            },
            child: const Text('Procesar'),
          ),
        ],
      ),
    );
  }

  String _getQRTypeTitle(String type) {
    switch (type) {
      case 'profile':
        return 'Perfil de Usuario';
      case 'payment':
        return 'Pago';
      case 'crypto':
        return 'Crypto';
      default:
        return 'Desconocido';
    }
  }

  void _processQR(dynamic qr) {
    switch (qr.type) {
      case 'payment':
        context.go('/send-money', extra: qr);
        break;
      case 'profile':
        _showProfileInfo(qr);
        break;
      case 'crypto':
        context.go('/crypto-market', extra: qr);
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tipo de QR no soportado')),
        );
    }
  }

  void _showProfileInfo(dynamic qr) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Perfil de Usuario'),
        content: const Text('¿Quieres agregar este usuario como contacto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Usuario agregado como contacto')),
              );
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
      child: Center(
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.primaryColor, width: 3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              // Corner indicators
              Positioned(
                top: -3,
                left: -3,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppTheme.primaryColor, width: 5),
                      left: BorderSide(color: AppTheme.primaryColor, width: 5),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -3,
                right: -3,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppTheme.primaryColor, width: 5),
                      right: BorderSide(color: AppTheme.primaryColor, width: 5),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -3,
                left: -3,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppTheme.primaryColor, width: 5),
                      left: BorderSide(color: AppTheme.primaryColor, width: 5),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -3,
                right: -3,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppTheme.primaryColor, width: 5),
                      right: BorderSide(color: AppTheme.primaryColor, width: 5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScannerControls() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_isScanning) {
                      _stopScanning();
                    } else {
                      _startScanning();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isScanning ? AppTheme.errorColor : AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _isScanning ? 'Detener Escaneo' : 'Iniciar Escaneo',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () => _toggleFlash(),
                icon: Icon(
                  _scannerController?.torchEnabled == true 
                    ? Icons.flash_off 
                    : Icons.flash_on,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showManualEntry(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Ingresar Manualmente',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showQRHistory(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Historial',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _startScanning() {
    setState(() {
      _isScanning = true;
    });
    _scannerController?.start();
  }

  void _stopScanning() {
    setState(() {
      _isScanning = false;
    });
    _scannerController?.stop();
  }

  void _toggleFlash() {
    _scannerController?.toggleTorch();
    setState(() {});
  }

  void _pickFromGallery() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función de galería en desarrollo')),
    );
  }

  void _showSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Configuración de cámara en desarrollo')),
    );
  }

  void _showManualEntry() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ingresar QR Manualmente'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Pega el código QR aquí',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('QR procesado manualmente')),
              );
            },
            child: const Text('Procesar'),
          ),
        ],
      ),
    );
  }

  void _showQRHistory(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Historial de QR en desarrollo')),
    );
  }
} 