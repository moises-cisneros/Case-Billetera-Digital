import 'package:flutter/material.dart';
import 'package:case_digital_wallet/core/presentation/widgets/base_page.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Notificaciones',
      child: Column(
        children: [
          // Configuración de notificaciones
          Card(
            child: Column(
              children: [
                _buildSwitchTile(
                  'Notificaciones Push',
                  'Recibir notificaciones en el dispositivo',
                  true,
                  (value) {
                    // TODO: Implementar toggle de notificaciones push
                  },
                ),
                _buildSwitchTile(
                  'Notificaciones SMS',
                  'Recibir alertas por mensaje de texto',
                  false,
                  (value) {
                    // TODO: Implementar toggle de notificaciones SMS
                  },
                ),
                _buildSwitchTile(
                  'Sonidos',
                  'Reproducir sonidos en las notificaciones',
                  true,
                  (value) {
                    // TODO: Implementar toggle de sonidos
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Lista de notificaciones
          Expanded(
            child: _buildNotificationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildNotificationsList() {
    // TODO: Implementar carga de notificaciones desde el servidor
    return ListView.builder(
      itemCount: _mockNotifications.length,
      itemBuilder: (context, index) {
        final notification = _mockNotifications[index];
        return Card(
          child: ListTile(
            leading: Icon(
              notification.icon,
              color: notification.color,
            ),
            title: Text(notification.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.message),
                const SizedBox(height: 4),
                Text(
                  notification.time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}

// Mock data para ejemplo
final _mockNotifications = [
  _NotificationItem(
    icon: Icons.payment,
    color: Colors.green,
    title: 'Transferencia exitosa',
    message: 'Has recibido Bs. 100.00 de Juan Pérez',
    time: 'Hace 5 minutos',
  ),
  _NotificationItem(
    icon: Icons.security,
    color: Colors.orange,
    title: 'Inicio de sesión',
    message: 'Nuevo inicio de sesión desde dispositivo Android',
    time: 'Hace 1 hora',
  ),
  _NotificationItem(
    icon: Icons.account_balance_wallet,
    color: Colors.blue,
    title: 'Depósito pendiente',
    message: 'Tu depósito de Bs. 500.00 está en proceso',
    time: 'Hace 2 horas',
  ),
];

class _NotificationItem {
  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final String time;

  _NotificationItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.time,
  });
}

// TODO: Implementar NotificationService
/*
abstract class NotificationService {
  Future<List<Notification>> getNotifications({int page = 1});
  Future<void> markAsRead(String notificationId);
  Future<void> updateNotificationSettings(NotificationSettings settings);
  Stream<Notification> get notificationStream;
}

class NotificationSettings {
  final bool pushEnabled;
  final bool smsEnabled;
  final bool soundEnabled;
  final List<String> categories;

  NotificationSettings({
    required this.pushEnabled,
    required this.smsEnabled,
    required this.soundEnabled,
    required this.categories,
  });
}
*/
