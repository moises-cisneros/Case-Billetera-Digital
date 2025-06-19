import 'package:flutter/material.dart';
import 'package:case_digital_wallet/core/presentation/widgets/base_page.dart';

class SecuritySettingsPage extends StatefulWidget {
  const SecuritySettingsPage({super.key});

  @override
  State<SecuritySettingsPage> createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  bool _biometricEnabled = false;
  bool _twoFactorEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSecuritySettings();
  }

  Future<void> _loadSecuritySettings() async {
    // TODO: Cargar configuraciones de seguridad desde el servicio
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Configuración de Seguridad',
      child: ListView(
        children: [
          _buildSection(
            'Acceso',
            [
              ListTile(
                title: const Text('Cambiar Contraseña'),
                leading: const Icon(Icons.password),
                onTap: () => _showChangePasswordDialog(context),
              ),
              ListTile(
                title: const Text('Cambiar PIN'),
                leading: const Icon(Icons.pin),
                onTap: () => _showChangePinDialog(context),
              ),
              SwitchListTile(
                title: const Text('Huella Digital / Face ID'),
                subtitle: const Text('Usar biometría para iniciar sesión'),
                value: _biometricEnabled,
                onChanged: (value) async {
                  // TODO: Implementar toggle de biometría
                  setState(() => _biometricEnabled = value);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            'Verificación en 2 Pasos',
            [
              SwitchListTile(
                title: const Text('Verificación en 2 Pasos'),
                subtitle: const Text('Añade una capa extra de seguridad'),
                value: _twoFactorEnabled,
                onChanged: (value) async {
                  if (value) {
                    await _showEnableTwoFactorDialog(context);
                  } else {
                    await _showDisableTwoFactorDialog(context);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            'Dispositivos',
            [
              ListTile(
                title: const Text('Dispositivos Conectados'),
                subtitle: const Text('Gestionar sesiones activas'),
                leading: const Icon(Icons.devices),
                onTap: () {
                  // TODO: Implementar gestión de dispositivos
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            'Límites y Restricciones',
            [
              ListTile(
                title: const Text('Límites de Transacción'),
                subtitle: const Text('Configurar límites diarios'),
                leading: const Icon(Icons.money),
                onTap: () {
                  // TODO: Implementar configuración de límites
                },
              ),
              ListTile(
                title: const Text('Bloqueo de Cuenta'),
                subtitle: const Text('Bloquear temporalmente la cuenta'),
                leading: const Icon(Icons.block),
                onTap: () => _showAccountBlockDialog(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Future<void> _showChangePasswordDialog(BuildContext context) async {
    // TODO: Implementar diálogo de cambio de contraseña
  }

  Future<void> _showChangePinDialog(BuildContext context) async {
    // TODO: Implementar diálogo de cambio de PIN
  }

  Future<void> _showEnableTwoFactorDialog(BuildContext context) async {
    // TODO: Implementar activación de 2FA
  }

  Future<void> _showDisableTwoFactorDialog(BuildContext context) async {
    // TODO: Implementar desactivación de 2FA
  }

  Future<void> _showAccountBlockDialog(BuildContext context) async {
    // TODO: Implementar diálogo de bloqueo de cuenta
  }
}

// TODO: Implementar SecurityService
/*
abstract class SecurityService {
  Future<SecuritySettings> getSecuritySettings();
  Future<void> updateSecuritySettings(SecuritySettings settings);
  Future<void> changePassword(String currentPassword, String newPassword);
  Future<void> changePin(String currentPin, String newPin);
  Future<void> enableTwoFactor();
  Future<void> disableTwoFactor(String code);
  Future<void> enableBiometric();
  Future<void> disableBiometric();
  Future<List<ConnectedDevice>> getConnectedDevices();
  Future<void> revokeDevice(String deviceId);
  Future<void> updateTransactionLimits(TransactionLimits limits);
  Future<void> blockAccount(BlockAccountRequest request);
}

class SecuritySettings {
  final bool biometricEnabled;
  final bool twoFactorEnabled;
  final TransactionLimits limits;
  final List<String> trustedDevices;

  SecuritySettings({
    required this.biometricEnabled,
    required this.twoFactorEnabled,
    required this.limits,
    required this.trustedDevices,
  });
}

class TransactionLimits {
  final double dailyTransferLimit;
  final double singleTransactionLimit;
  final bool requirePinAboveAmount;
  final double pinRequiredAmount;

  TransactionLimits({
    required this.dailyTransferLimit,
    required this.singleTransactionLimit,
    required this.requirePinAboveAmount,
    required this.pinRequiredAmount,
  });
}
*/
