import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:camera/camera.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';
import 'dart:io';

class KycSelfiePage extends StatefulWidget {
  const KycSelfiePage({super.key});

  @override
  State<KycSelfiePage> createState() => _KycSelfiePageState();
}

class _KycSelfiePageState extends State<KycSelfiePage> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  bool _isLoading = false;
  File? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();

      // Find front camera
      CameraDescription? frontCamera;
      for (var camera in _cameras!) {
        if (camera.lensDirection == CameraLensDirection.front) {
          frontCamera = camera;
          break;
        }
      }

      if (frontCamera != null) {
        _controller = CameraController(
          frontCamera,
          ResolutionPreset.high,
          enableAudio: false,
        );

        await _controller!.initialize();

        if (mounted) {
          setState(() => _isInitialized = true);
        }
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      setState(() => _isLoading = true);

      final XFile image = await _controller!.takePicture();

      setState(() {
        _capturedImage = File(image.path);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al tomar la foto: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  void _retakePicture() {
    setState(() => _capturedImage = null);
  }

  void _confirmPicture() async {
    setState(() => _isLoading = true);

    try {
      // Simulate API upload and KYC processing
      await Future.delayed(const Duration(seconds: 3));

      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppTheme.successColor,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '¡Verificación enviada!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Tu documentación ha sido enviada para verificación. Te notificaremos cuando esté lista.',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.go('/home');
                },
                child: const Text('Continuar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Toma tu selfie'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/kyc-document'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Instructions
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black,
              child: const Column(
                children: [
                  Text(
                    'Coloca tu rostro dentro del círculo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Mantén una expresión neutral y mira directamente a la cámara',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Camera preview or captured image
            Expanded(
              child: _capturedImage != null
                  ? _buildImagePreview()
                  : _buildCameraPreview(),
            ),

            // Controls
            Container(
              padding: const EdgeInsets.all(24),
              color: Colors.black,
              child: _capturedImage != null
                  ? _buildImageControls()
                  : _buildCameraControls(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (!_isInitialized || _controller == null) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return Stack(
      children: [
        // Camera preview
        Center(
          child: AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: CameraPreview(_controller!),
          ),
        ),

        // Face overlay
        Center(
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.primaryColor,
                width: 4,
              ),
            ),
          ),
        ),

        // Guidelines
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 300),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Centra tu rostro en el círculo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 400),
        child: ClipOval(
          child: Image.file(
            _capturedImage!,
            fit: BoxFit.cover,
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }

  Widget _buildCameraControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Switch camera (placeholder)
        IconButton(
          onPressed: () {
            // TODO: Implement camera switch
          },
          icon: const Icon(
            Icons.flip_camera_ios,
            color: Colors.white,
            size: 32,
          ),
        ),

        // Capture button
        GestureDetector(
          onTap: _isLoading ? null : _takePicture,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _isLoading ? Colors.grey : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 4,
              ),
            ),
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 32,
                  ),
          ),
        ),

        // Help button
        IconButton(
          onPressed: () {
            _showHelpDialog();
          },
          icon: const Icon(
            Icons.help_outline,
            color: Colors.white,
            size: 32,
          ),
        ),
      ],
    );
  }

  Widget _buildImageControls() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isLoading ? null : _retakePicture,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Tomar otra'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading ? null : _confirmPicture,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text('Enviar verificación'),
          ),
        ),
      ],
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Consejos para una buena selfie'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Asegúrate de tener buena iluminación'),
            Text('• Mantén una expresión neutral'),
            Text('• Mira directamente a la cámara'),
            Text('• No uses lentes oscuros o sombreros'),
            Text('• Centra tu rostro en el círculo'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }
}
