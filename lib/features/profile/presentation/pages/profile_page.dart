import 'package:flutter/material.dart';
import 'package:case_digital_wallet/core/presentation/widgets/base_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Perfil',
      child: ListView(
        children: [
          // Avatar y nombre
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  // TODO: Implementar carga de imagen de perfil
                  // backgroundImage: NetworkImage(user.photoUrl),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Juan Pérez', // TODO: Obtener nombre del usuario
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '+51 999 999 999', // TODO: Obtener teléfono del usuario
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Información del perfil
          _buildSection(
            'Información Personal',
            [
              _buildInfoTile('Correo', 'juan.perez@example.com'),
              _buildInfoTile('Documento', 'DNI: 12345678'),
              _buildInfoTile('Dirección', 'Av. Principal 123'),
            ],
          ),

          const SizedBox(height: 16),

          // Estado KYC
          _buildSection(
            'Estado de Verificación',
            [
              _buildStatusTile(
                'Verificación de Identidad',
                'Verificado',
                Icons.verified,
                Colors.green,
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
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
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

  Widget _buildInfoTile(String label, String value) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
      trailing: const Icon(Icons.edit, size: 20),
      onTap: () {
        // TODO: Implementar edición de campo
      },
    );
  }

  Widget _buildStatusTile(
      String label, String status, IconData icon, Color color) {
    return ListTile(
      title: Text(label),
      subtitle: Text(status),
      trailing: Icon(icon, color: color),
    );
  }
}

// TODO: Implementar ProfileService
/*
abstract class ProfileService {
  Future<UserProfile> getUserProfile();
  Future<void> updateProfile(ProfileUpdateRequest request);
  Future<void> updateProfilePicture(File image);
}
*/
