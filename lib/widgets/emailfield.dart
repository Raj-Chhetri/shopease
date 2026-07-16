import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmailField extends StatelessWidget {
  final String text;
  final String hintText;
  final IconData icon;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final Iterable<String>? autofillHints;

  final String? Function(String?)? validator;

  final void Function(String)? onFieldSubmitted;

  const EmailField({
    super.key,
    required this.text,
    required this.hintText,
    required this.icon,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff5B6475),
          ),
        ),

        const Gap(12),

        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,

          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF6F3FF),
            contentPadding: const EdgeInsets.symmetric(vertical: 20),

            hintText: hintText,

            prefixIcon: Icon(
              icon,
              color: const Color(0xFF6D28FF),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: const BorderSide(
                color: Color(0xffE5E7EB),
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: const BorderSide(
                color: Color(0xffE5E7EB),
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: const BorderSide(color: Colors.red),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),

        const Gap(30),
      ],
    );
  }
}