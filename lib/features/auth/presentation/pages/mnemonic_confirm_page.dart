import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';
import 'dart:math';

class MnemonicConfirmPage extends StatefulWidget {
  final List<String> mnemonicWords;

  const MnemonicConfirmPage({super.key, required this.mnemonicWords});

  @override
  State<MnemonicConfirmPage> createState() => _MnemonicConfirmPageState();
}

class _MnemonicConfirmPageState extends State<MnemonicConfirmPage> {
  late List<String> _shuffledWords;
  // This will store indices into _shuffledWords, maintaining selection order.
  late List<int> _selectedShuffledIndices;
  // These are the indices from the *original* mnemonicWords list that need to be confirmed.
  late List<int> _confirmationOriginalIndices;

  @override
  void initState() {
    super.initState();
    _shuffledWords = List.from(widget.mnemonicWords)..shuffle();
    _selectedShuffledIndices = [];
    _confirmationOriginalIndices = _generateConfirmationIndices();
  }

  List<int> _generateConfirmationIndices() {
    final random = Random();
    final Set<int> indices = {};
    while (indices.length < 4) {
      indices.add(random.nextInt(widget.mnemonicWords.length));
    }
    // Sort these indices to define the *correct original order* for confirmation.
    return indices.toList()..sort();
  }

  void _onWordSelected(int tappedShuffledIndex) {
    setState(() {
      if (_selectedShuffledIndices.contains(tappedShuffledIndex)) {
        // If the word is already selected, deselect it
        _selectedShuffledIndices.remove(tappedShuffledIndex);
      } else if (_selectedShuffledIndices.length < 4) {
        // If less than 4 words are selected, add it
        _selectedShuffledIndices.add(tappedShuffledIndex);
      }
      // If 4 words are already selected and a new one is tapped, do nothing (don't allow more than 4)
    });
  }

  bool _isValidConfirmation() {
    // Must select exactly 4 words
    if (_selectedShuffledIndices.length != 4) {
      return false;
    }

    // Get the words the user selected, in the order they were selected.
    final List<String> userSelectedWordsInOrder = _selectedShuffledIndices
        .map((shuffledIndex) => _shuffledWords[shuffledIndex])
        .toList();

    // Get the expected words from the original mnemonic, based on the confirmation indices and their order.
    final List<String> expectedWordsInOrder = _confirmationOriginalIndices
        .map((originalIndex) => widget.mnemonicWords[originalIndex])
        .toList();

    // Compare the user's selected words (in order) with the expected words (in order).
    for (int i = 0; i < 4; i++) {
      if (userSelectedWordsInOrder[i] != expectedWordsInOrder[i]) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // Get the words selected for display in the confirmation area, preserving their selection order.
    List<String> displayedSelectedWords = _selectedShuffledIndices
        .map((shuffledIndex) => _shuffledWords[shuffledIndex])
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirma tu Frase de Recuperación'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Selecciona las palabras en el orden correcto para confirmar tu frase de recuperación.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 32),
            // Display which words/positions need to be confirmed (e.g., "Word at position 2, Word at position 7, ...")
            Text(
              'Por favor, selecciona las palabras en las posiciones originales: '
              '${_confirmationOriginalIndices.map((e) => e + 1).join(', ')}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _shuffledWords.asMap().entries.map((entry) {
                final shuffledIndex = entry.key;
                final word = entry.value;
                final isSelected =
                    _selectedShuffledIndices.contains(shuffledIndex);
                return ActionChip(
                  label: Text(word),
                  backgroundColor: isSelected
                      ? AppTheme.primaryColor
                      : AppTheme.textSecondary,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.textPrimary,
                  ),
                  onPressed: () => _onWordSelected(shuffledIndex),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.primaryColor),
              ),
              child: Text(
                displayedSelectedWords.isEmpty
                    ? 'Palabras seleccionadas aparecerán aquí'
                    : displayedSelectedWords.join(' '),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isValidConfirmation()
                  ? () {
                      context.go('/registration-success');
                    }
                  : null,
              child: const Text('Confirmar y Crear Billetera'),
            ),
          ],
        ),
      ),
    );
  }
}
