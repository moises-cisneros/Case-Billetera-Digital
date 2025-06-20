import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/onboarding_1.png',
      'title': 'Bienvenido a la Auto-Custodia',
      'description':
          'Toma control total de tus activos. Con CASE, tú eres el único dueño de tu dinero.',
    },
    {
      'image': 'assets/images/onboarding_2.png',
      'title': '¿Qué es un Mnemonic?',
      'description':
          'Tu mnemonic de 12 palabras es la clave maestra para recuperar tu billetera. ¡Guárdalo como oro!',
    },
    {
      'image': 'assets/images/onboarding_3.png',
      'title': 'La Seguridad es Tu Responsabilidad',
      'description':
          'Nadie más tiene acceso a tu mnemonic. Si lo pierdes, pierdes tus fondos para siempre.',
    },
    {
      'image': 'assets/images/onboarding_4.png',
      'title': 'Nunca Compartas tu Mnemonic',
      'description':
          'Mantén tus 12 palabras en secreto. Son la única forma de acceder a tu billetera.',
    },
    {
      'image': 'assets/images/onboarding_5.png',
      'title': '¡Estás Listo!',
      'description':
          'Aprenderás a guardar tu mnemonic y asegurar tus fondos. ¡Empecemos!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => context.go('/home'),
            child: const Text('Saltar'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(onboardingData[index]['image']!, height: 200),
                      const SizedBox(height: 32),
                      Text(
                        onboardingData[index]['title']!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        onboardingData[index]['description']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppTheme.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      height: 8.0,
                      width: _currentPage == index ? 24.0 : 8.0,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? AppTheme.primaryColor
                            : AppTheme.textSecondary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage < onboardingData.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        // Last page, navigate to mnemonic generation
                        context.go('/mnemonic-display'); // Will be created next
                      }
                    },
                    child: Text(_currentPage == onboardingData.length - 1
                        ? 'Entendido'
                        : 'Siguiente'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
