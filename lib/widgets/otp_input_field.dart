import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autofocus;
  final bool isLastField;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspace;
  final VoidCallback onSubmitted;

  const OtpInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.autofocus,
    required this.isLastField,
    required this.onChanged,
    required this.onBackspace,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return KeyboardListener(
      focusNode: FocusNode(skipTraversal: true),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace &&
            controller.text.isEmpty) {
          onBackspace();
        }
      },
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        keyboardType: TextInputType.number,
        textInputAction:
            isLastField ? TextInputAction.done : TextInputAction.next,
        textAlign: TextAlign.center,
        autofillHints: const [
          AutofillHints.oneTimeCode,
        ],
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF6D28FF),
              width: 2,
            ),
          ),
        ),
        onChanged: onChanged,
        onFieldSubmitted: (_) => onSubmitted(),
      ),
    );
  }
}