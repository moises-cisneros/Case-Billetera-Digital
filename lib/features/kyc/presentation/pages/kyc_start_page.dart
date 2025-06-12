import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';

class KycStartPage extends StatelessWidget {
  const KycStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificación de identidad'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 32),

              // Icon
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.verified_user,
                  size: 64,
                  color: AppTheme.primaryColor,
                ),
              ),

              const SizedBox(height: 32),

              // Title
              const Text(
                'Verifica tu identidad',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Subtitle
              const Text(
                'Para tu seguridad y cumplir con las regulaciones, necesitamos verificar tu identidad.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Requirements
              _buildRequirementsList(),

              const Spacer(),

              // Start button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/kyc-document'),
                  child: const Text('Comenzar verificación'),
                ),
              ),

              const SizedBox(height: 16),

              // Skip button
              TextButton(
                onPressed: () => context.go('/home'),
                child: const Text(
                  'Verificar más tarde',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementsList() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Necesitarás:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildRequirementItem(
            Icons.credit_card,
            'Carnet de identidad',
            'Documento vigente y en buen estado',
          ),
          const SizedBox(height: 12),
          _buildRequirementItem(
            Icons.camera_alt,
            'Selfie',
            'Foto clara de tu rostro',
          ),
          const SizedBox(height: 12),
          _buildRequirementItem(
            Icons.timer,
            'Tiempo estimado',
            '2-3 minutos',
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
