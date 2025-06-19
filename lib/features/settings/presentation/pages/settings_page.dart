import 'package:flutter/material.dart';
import 'package:case_digital_wallet/core/presentation/widgets/base_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Configuración',
      child: ListView(
        children: [
          _buildSection(
            'Preferencias',
            [
              _buildSettingTile(
                'Notificaciones',
                'Gestionar notificaciones',
                Icons.notifications,
                onTap: () => Navigator.pushNamed(context, '/notifications'),
              ),
              _buildSettingTile(
                'Seguridad',
                'Contraseña, PIN y biometría',
                Icons.security,
                onTap: () => Navigator.pushNamed(context, '/security'),
              ),
              _buildSettingTile(
                'Idioma',
                'Español',
                Icons.language,
                onTap: () {
                  // TODO: Implementar cambio de idioma
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            'Actividad',
            [
              _buildSettingTile(
                'Historial de Actividad',
                'Ver todas las acciones realizadas',
                Icons.history,
                onTap: () => Navigator.pushNamed(context, '/activity-log'),
              ),
              _buildSettingTile(
                'Dispositivos Conectados',
                'Gestionar sesiones activas',
                Icons.devices,
                onTap: () {
                  // TODO: Implementar gestión de dispositivos
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            'Ayuda',
            [
              _buildSettingTile(
                'Centro de Ayuda',
                'Preguntas frecuentes y soporte',
                Icons.help,
                onTap: () => Navigator.pushNamed(context, '/faq'),
              ),
              _buildSettingTile(
                'Soporte',
                'Contactar a servicio al cliente',
                Icons.support_agent,
                onTap: () => Navigator.pushNamed(context, '/support'),
              ),
              _buildSettingTile(
                'Términos y Condiciones',
                'Ver términos legales',
                Icons.description,
                onTap: () {
                  // TODO: Implementar vista de términos
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildDangerSection(),
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

  Widget _buildSettingTile(
    String title,
    String subtitle,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildDangerSection() {
    return Card(
      color: Colors.red[50],
      child: ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text(
          'Cerrar Sesión',
          style: TextStyle(color: Colors.red),
        ),
        onTap: () {
          // TODO: Implementar cierre de sesión
        },
      ),
    );
  }
}

// TODO: Implementar SettingsService
/*
abstract class SettingsService {
  Future<AppSettings> getSettings();
  Future<void> updateSettings(AppSettings settings);
  Future<void> updateLanguage(String languageCode);
  Future<List<ConnectedDevice>> getConnectedDevices();
  Future<void> revokeDevice(String deviceId);
  Future<void> logout();
}

class AppSettings {
  final bool pushNotificationsEnabled;
  final bool emailNotificationsEnabled;
  final bool smsNotificationsEnabled;
  final String language;
  final bool biometricEnabled;
  final bool darkModeEnabled;

  AppSettings({
    required this.pushNotificationsEnabled,
    required this.emailNotificationsEnabled,
    required this.smsNotificationsEnabled,
    required this.language,
    required this.biometricEnabled,
    required this.darkModeEnabled,
  });
}
*/
