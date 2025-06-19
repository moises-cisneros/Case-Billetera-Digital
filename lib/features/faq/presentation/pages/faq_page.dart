import 'package:flutter/material.dart';
import 'package:case_digital_wallet/core/presentation/widgets/base_page.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Preguntas Frecuentes',
      child: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar pregunta...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (query) {
                // TODO: Implementar búsqueda en FAQs
              },
            ),
          ),
          const SizedBox(height: 16),

          // Lista de categorías y preguntas
          Expanded(
            child: ListView(
              children: _faqCategories.map((category) {
                return _buildFAQCategory(category);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQCategory(FAQCategory category) {
    return ExpansionTile(
      title: Text(
        category.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: category.questions.map((question) {
        return _buildFAQItem(question);
      }).toList(),
    );
  }

  Widget _buildFAQItem(FAQItem item) {
    return ExpansionTile(
      title: Text(item.question),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.answer,
                style: const TextStyle(color: Colors.grey),
              ),
              if (item.helpfulLink != null) ...[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // TODO: Implementar apertura de enlace
                  },
                  child: Text(
                    'Ver más información',
                    style: TextStyle(color: Colors.blue[700]),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class FAQCategory {
  final String name;
  final List<FAQItem> questions;

  FAQCategory({
    required this.name,
    required this.questions,
  });
}

class FAQItem {
  final String question;
  final String answer;
  final String? helpfulLink;

  FAQItem({
    required this.question,
    required this.answer,
    this.helpfulLink,
  });
}

// Mock data para ejemplo
final _faqCategories = [
  FAQCategory(
    name: 'Cuenta y Seguridad',
    questions: [
      FAQItem(
        question: '¿Cómo cambio mi contraseña?',
        answer:
            'Para cambiar tu contraseña, ve a Configuración > Seguridad > Cambiar Contraseña. Deberás ingresar tu contraseña actual y la nueva contraseña.',
      ),
      FAQItem(
        question: '¿Qué hago si olvidé mi PIN?',
        answer:
            'Si olvidaste tu PIN, puedes restablecerlo desde la opción "Olvidé mi PIN" en la pantalla de ingreso del PIN. Se te enviará un código de verificación por SMS.',
      ),
    ],
  ),
  FAQCategory(
    name: 'Transferencias y Pagos',
    questions: [
      FAQItem(
        question: '¿Cuál es el límite de transferencia?',
        answer:
            'Los límites de transferencia dependen de tu nivel de verificación. Con verificación básica, puedes transferir hasta Bs. 1,000 por día.',
        helpfulLink: 'https://casewallet.com/limites',
      ),
      FAQItem(
        question: '¿Cuánto demoran las transferencias?',
        answer:
            'Las transferencias entre usuarios de Case Wallet son instantáneas. Las transferencias bancarias pueden demorar hasta 24 horas hábiles.',
      ),
    ],
  ),
  FAQCategory(
    name: 'Verificación de Identidad',
    questions: [
      FAQItem(
        question: '¿Por qué debo verificar mi identidad?',
        answer:
            'La verificación de identidad es un requisito legal para prevenir el fraude y cumplir con las regulaciones financieras.',
        helpfulLink: 'https://casewallet.com/kyc',
      ),
    ],
  ),
];

// TODO: Implementar FAQService
/*
abstract class FAQService {
  Future<List<FAQCategory>> getFAQCategories();
  Future<List<FAQItem>> searchFAQs(String query);
  Future<void> rateFAQHelpfulness(String faqId, bool wasHelpful);
}
*/
