import 'package:flutter/material.dart';
import 'package:case_digital_wallet/core/presentation/widgets/base_page.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Soporte',
      child: ListView(
        children: [
          // Sección de contacto rápido
          _buildSection(
            'Contacto Rápido',
            [
              _buildContactTile(
                'Chat en Vivo',
                'Habla con un agente ahora',
                Icons.chat,
                Colors.blue,
                () {
                  // TODO: Implementar integración con servicio de chat (e.j. Zendesk, Intercom)
                },
              ),
              _buildContactTile(
                'WhatsApp',
                'Escríbenos por WhatsApp',
                Icons.whatshot,
                Colors.green,
                () {
                  // TODO: Implementar deep linking a WhatsApp business
                },
              ),
              _buildContactTile(
                'Correo Electrónico',
                'soporte@casewallet.com',
                Icons.email,
                Colors.red,
                () {
                  // TODO: Implementar envío de correo
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Sección de ticket de soporte
          _buildSection(
            'Crear Ticket',
            [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Tipo de Problema',
                      ),
                      items: _problemTypes.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) {
                        // TODO: Implementar selección de tipo de problema
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Describe tu problema',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implementar envío de ticket
                      },
                      child: const Text('Enviar Ticket'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Sección de tickets anteriores
          _buildSection(
            'Mis Tickets',
            [
              // TODO: Implementar lista de tickets anteriores
              const ListTile(
                title: Text('No hay tickets previos'),
                subtitle: Text('Tus tickets aparecerán aquí'),
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

  Widget _buildContactTile(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

const _problemTypes = [
  'Problema con transferencia',
  'No puedo iniciar sesión',
  'Problema con depósito',
  'Problema con retiro',
  'Verificación de identidad',
  'Otro',
];

// TODO: Implementar SupportService
/*
abstract class SupportService {
  Future<String> createTicket(SupportTicket ticket);
  Future<List<SupportTicket>> getTickets();
  Future<void> updateTicket(String ticketId, TicketUpdate update);
  Future<void> startChat();
}

class SupportTicket {
  final String id;
  final String type;
  final String description;
  final String status;
  final DateTime createdAt;
  final List<TicketMessage> messages;

  SupportTicket({
    required this.id,
    required this.type,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.messages,
  });
}
*/
