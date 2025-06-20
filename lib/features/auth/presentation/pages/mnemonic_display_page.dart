import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';

class MnemonicDisplayPage extends StatefulWidget {
  const MnemonicDisplayPage({super.key});

  @override
  State<MnemonicDisplayPage> createState() => _MnemonicDisplayPageState();
}

class _MnemonicDisplayPageState extends State<MnemonicDisplayPage> {
  List<String> _mnemonicWords = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _generateMnemonic();
  }

  Future<void> _generateMnemonic() async {
    setState(() {
      _isLoading = true;
    });
    // Simulate API call for mnemonic generation
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _mnemonicWords = [
        "word1",
        "word2",
        "word3",
        "word4",
        "word5",
        "word6",
        "word7",
        "word8",
        "word9",
        "word10",
        "word11",
        "word12"
      ]; // Mock words
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Frase de Recuperación'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Escribe estas 12 palabras en el orden correcto y guárdalas en un lugar seguro. ¡Son la única forma de recuperar tu billetera!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 32),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2.5,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _mnemonicWords.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.primaryColor),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 1}. ${_mnemonicWords[index]}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      context.go('/mnemonic-confirm', extra: _mnemonicWords);
                    },
              child: const Text('He guardado mis palabras'),
            ),
          ],
        ),
      ),
    );
  }
}
