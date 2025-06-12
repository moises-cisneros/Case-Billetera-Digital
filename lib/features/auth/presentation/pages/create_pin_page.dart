import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';
import 'package:case_digital_wallet/core/config/app_config.dart';

class CreatePinPage extends StatefulWidget {
  const CreatePinPage({super.key});

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  final List<TextEditingController> _controllers = List.generate(
    AppConfig.pinLength,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    AppConfig.pinLength,
    (index) => FocusNode(),
  );

  bool _isLoading = false;
  bool _isConfirming = false;
  String _firstPin = '';

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _clearPin() {
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
  }

  void _handlePinComplete() async {
    final pin = _controllers.map((c) => c.text).join();

    if (!_isConfirming) {
      // First PIN entry
      setState(() {
        _firstPin = pin;
        _isConfirming = true;
      });
      _clearPin();
    } else {
      // PIN confirmation
      if (pin == _firstPin) {
        setState(() => _isLoading = true);

        try {
          // Simulate API call
          await Future.delayed(const Duration(seconds: 2));

          if (mounted) {
            context.go('/kyc-start');
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${e.toString()}'),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        } finally {
          if (mounted) {
            setState(() => _isLoading = false);
          }
        }
      } else {
        // PINs don't match
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Los PINs no coinciden. Intenta nuevamente.'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        setState(() {
          _isConfirming = false;
          _firstPin = '';
        });
        _clearPin();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear PIN'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/create-password'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              // Title
              Text(
                _isConfirming ? 'Confirma tu PIN' : 'Crea un PIN de seguridad',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Subtitle
              Text(
                _isConfirming
                    ? 'Ingresa nuevamente tu PIN de 4 dígitos'
                    : 'Usarás este PIN para confirmar transacciones',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 64),

              // PIN Input
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(AppConfig.pinLength, (index) {
                  return SizedBox(
                    width: 60,
                    child: TextFormField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      obscureText: true,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                      ),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty &&
                            index < AppConfig.pinLength - 1) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }

                        // Auto submit when all fields are filled
                        if (index == AppConfig.pinLength - 1 &&
                            value.isNotEmpty) {
                          final pin = _controllers.map((c) => c.text).join();
                          if (pin.length == AppConfig.pinLength) {
                            _handlePinComplete();
                          }
                        }
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 32),

              // Security info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: AppTheme.primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Seguridad',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Tu PIN se almacena de forma segura y encriptada',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              if (_isLoading)
                const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Creando tu cuenta...',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
