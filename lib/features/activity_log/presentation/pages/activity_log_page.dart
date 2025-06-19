import 'package:flutter/material.dart';
import 'package:case_digital_wallet/core/presentation/widgets/base_page.dart';

class ActivityLogPage extends StatelessWidget {
  const ActivityLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Registro de Actividad',
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            // TODO: Implementar filtros de actividad
          },
        ),
      ],
      child: Column(
        children: [
          // Filtros rápidos
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                _buildFilterChip('Hoy'),
                _buildFilterChip('Esta semana'),
                _buildFilterChip('Inicios de sesión'),
                _buildFilterChip('Transferencias'),
                _buildFilterChip('Seguridad'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Lista de actividades
          Expanded(
            child: ListView.builder(
              itemCount: _mockActivities.length,
              itemBuilder: (context, index) {
                final activity = _mockActivities[index];
                return _buildActivityTile(activity);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        label: Text(label),
        selected: false,
        onSelected: (selected) {
          // TODO: Implementar filtrado
        },
      ),
    );
  }

  Widget _buildActivityTile(ActivityItem activity) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: activity.color.withOpacity(0.1),
          child: Icon(activity.icon, color: activity.color, size: 20),
        ),
        title: Text(activity.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(activity.description),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, size: 12, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  activity.time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8),
                if (activity.location != null) ...[
                  Icon(Icons.location_on, size: 12, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    activity.location!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        isThreeLine: true,
        onTap: () {
          // TODO: Mostrar detalles de la actividad
        },
      ),
    );
  }
}

class ActivityItem {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final String time;
  final String? location;
  final String? deviceInfo;

  ActivityItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.time,
    this.location,
    this.deviceInfo,
  });
}

// Mock data para ejemplo
final _mockActivities = [
  ActivityItem(
    icon: Icons.login,
    color: Colors.blue,
    title: 'Inicio de sesión',
    description: 'Inicio de sesión exitoso',
    time: '13/06/2025 10:30',
    location: 'La Paz, Bolivia',
    deviceInfo: 'Android 14 - Samsung Galaxy S23',
  ),
  ActivityItem(
    icon: Icons.security,
    color: Colors.orange,
    title: 'Cambio de contraseña',
    description: 'Se cambió la contraseña de la cuenta',
    time: '13/06/2025 09:15',
    location: 'La Paz, Bolivia',
  ),
  ActivityItem(
    icon: Icons.payment,
    color: Colors.green,
    title: 'Transferencia enviada',
    description: 'Bs. 500.00 enviados a María López',
    time: '12/06/2025 18:45',
  ),
];

// TODO: Implementar ActivityLogService
/*
abstract class ActivityLogService {
  Future<List<ActivityItem>> getActivities({
    DateTime? startDate,
    DateTime? endDate,
    String? type,
    int page = 1,
  });
  
  Future<ActivityDetails> getActivityDetails(String activityId);
  
  Future<List<String>> getActivityLocations();
  
  Future<void> exportActivityLog({
    required DateTime startDate,
    required DateTime endDate,
    String format = 'PDF',
  });
}

class ActivityDetails {
  final String id;
  final String type;
  final DateTime timestamp;
  final String description;
  final String location;
  final String ipAddress;
  final String deviceInfo;
  final Map<String, dynamic> additionalData;

  ActivityDetails({
    required this.id,
    required this.type,
    required this.timestamp,
    required this.description,
    required this.location,
    required this.ipAddress,
    required this.deviceInfo,
    required this.additionalData,
  });
}
*/
