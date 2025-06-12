import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';
import 'dart:convert';

class ReceiveMoneyPage extends StatefulWidget {
  const ReceiveMoneyPage({super.key});

  @override
  State<ReceiveMoneyPage> createState() => _ReceiveMoneyPageState();
}

class _ReceiveMoneyPageState extends State<ReceiveMoneyPage> {
  final _amountController = TextEditingController();
  String? _qrData;
  bool _showQR = false;

  // Mock user data
  final String _userName = 'Usuario CASE';
  final String _userPhone = '12345678';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _generateQR() {
    final amount = _amountController.text.trim();

    if (amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingresa un monto'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    final qrPayload = {
      'type': 'case_payment',
      'phone': _userPhone,
      'name': _userName,
      'amount': amount,
      'currency': 'BS',
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    setState(() {
      _qrData = jsonEncode(qrPayload);
      _showQR = true;
    });
  }

  void _shareQR() {
    if (_qrData != null) {
      // TODO: Implement share functionality
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Función de compartir próximamente'),
          backgroundColor: AppTheme.primaryColor,
        ),
      );
    }
  }

  void _copyPaymentLink() {
    if (_qrData != null) {
      final paymentLink =
          'https://case.bo/pay?data=${Uri.encodeComponent(_qrData!)}';
      Clipboard.setData(ClipboardData(text: paymentLink));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enlace copiado al portapapeles'),
          backgroundColor: AppTheme.successColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cobrar dinero'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        actions: _showQR
            ? [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: _shareQR,
                  tooltip: 'Compartir',
                ),
              ]
            : null,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!_showQR) ...[
                // User info card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryColor, Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _userName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '+591 $_userPhone',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Amount input
                const Text(
                  'Monto a cobrar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: '0.00',
                    prefixText: 'Bs ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  ),
                ),

                const SizedBox(height: 32),

                // Generate QR button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _generateQR,
                    icon: const Icon(Icons.qr_code),
                    label: const Text('Generar código QR'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Instructions
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppTheme.primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Cómo funciona',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        '1. Ingresa el monto que quieres cobrar\n'
                        '2. Genera el código QR\n'
                        '3. Comparte el código con quien te va a pagar\n'
                        '4. Recibirás el dinero instantáneamente',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // QR Code display
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      QrImageView(
                        data: _qrData!,
                        version: QrVersions.auto,
                        size: 250.0,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Bs ${_amountController.text}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _userName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        '+591 $_userPhone',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _copyPaymentLink,
                        icon: const Icon(Icons.link),
                        label: const Text('Copiar enlace'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _shareQR,
                        icon: const Icon(Icons.share),
                        label: const Text('Compartir'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // New amount button
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _showQR = false;
                      _qrData = null;
                      _amountController.clear();
                    });
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Cambiar monto'),
                ),

                const SizedBox(height: 24),

                // Security note
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.security,
                        color: AppTheme.successColor,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pago seguro',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Este código QR es único y seguro. Solo funciona para el monto especificado.',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.successColor.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
