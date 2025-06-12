import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:camera/camera.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';
import 'dart:io';

class KycDocumentPage extends StatefulWidget {
  const KycDocumentPage({super.key});

  @override
  State<KycDocumentPage> createState() => _KycDocumentPageState();
}

class _KycDocumentPageState extends State<KycDocumentPage> {
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
      if (_cameras!.isNotEmpty) {
        _controller = CameraController(
          _cameras![0],
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
      // Simulate API upload
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        context.go('/kyc-selfie');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Fotografía tu carnet'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/kyc-start'),
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
                    'Coloca tu carnet dentro del marco',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Asegúrate de que esté bien iluminado y sea legible',
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

        // Overlay frame
        Center(
          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.primaryColor,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                // Corner indicators
                Positioned(
                  top: -3,
                  left: -3,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -3,
                  right: -3,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -3,
                  left: -3,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -3,
                  right: -3,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 400),
        child: Image.file(
          _capturedImage!,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildCameraControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Flash toggle (placeholder)
        IconButton(
          onPressed: () {
            // TODO: Implement flash toggle
          },
          icon: const Icon(
            Icons.flash_off,
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

        // Gallery button (placeholder)
        IconButton(
          onPressed: () {
            // TODO: Implement gallery picker
          },
          icon: const Icon(
            Icons.photo_library,
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
                : const Text('Continuar'),
          ),
        ),
      ],
    );
  }
}
