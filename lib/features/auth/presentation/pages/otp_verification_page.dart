import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';
import 'package:case_digital_wallet/core/config/app_config.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;
  
  const OtpVerificationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _controllers = List.generate(
    AppConfig.otpLength,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    AppConfig.otpLength,
    (index) => FocusNode(),
  );
  
  bool _isLoading = false;
  int _resendCountdown = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

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

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (_resendCountdown > 0) {
            _resendCountdown--;
            _startCountdown();
          } else {
            _canResend = true;
          }
        });
      }
    });
  }

  void _verifyOtp() async {
    final otp = _controllers.map((c) => c.text).join();
    
    if (otp.length != AppConfig.otpLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingresa el código completo'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        context.go('/create-password');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Código incorrecto: ${e.toString()}'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _resendCode() async {
    setState(() {
      _canResend = false;
      _resendCountdown = 60;
    });
    _startCountdown();
    
    // Simulate resend API call
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Código reenviado'),
          backgroundColor: AppTheme.successColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificación'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/register'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              
              // Title
              const Text(
                'Ingresa el código de verificación',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Subtitle
              Text(
                'Enviamos un código de 6 dígitos a +591 ${widget.phoneNumber}',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
              
              const SizedBox(height: 48),
              
              // OTP Input
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(AppConfig.otpLength, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextFormField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < AppConfig.otpLength - 1) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                        
                        // Auto verify when all fields are filled
                        if (index == AppConfig.otpLength - 1 && value.isNotEmpty) {
                          final otp = _controllers.map((c) => c.text).join();
                          if (otp.length == AppConfig.otpLength) {
                            _verifyOtp();
                          }
                        }
                      },
                    ),
                  );
                }),
              ),
              
              const SizedBox(height: 32),
              
              // Resend code
              Center(
                child: TextButton(
                  onPressed: _canResend ? _resendCode : null,
                  child: Text(
                    _canResend 
                        ? 'Reenviar código'
                        : 'Reenviar código en ${_resendCountdown}s',
                    style: TextStyle(
                      color: _canResend ? AppTheme.primaryColor : AppTheme.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Verify button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOtp,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Verificar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}