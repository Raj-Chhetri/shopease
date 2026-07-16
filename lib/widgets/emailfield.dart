
// import 'dart:core';

// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';

// class EmailField extends StatelessWidget {
//   final String text;
//   final String hintText;
//   final IconData icon;
//   final TextInputType? keyboardType;

//     const EmailField({
//     super.key,
//     required this.text,
//     required this.hintText,
//     required this.icon,
//     this.keyboardType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Color(0xff5B6475),
//             ),
//           ),
//           Gap(12),
//           TextFormField(
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Color(0xffF6F3FF),
//               contentPadding: EdgeInsets.symmetric(vertical: 20),
//               hint: Text(
//                 hintText,
//                 style: TextStyle(color: Color(0xFF5B6475), fontSize: 15),
//               ),
          
//               prefixIcon: Icon(
//                 icon,
//                 color: Color(0xFF6D28FF),
//                 // size: 20,
//               ),
          
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(17),
//                 borderSide: BorderSide(color: Color(0xffE5E7EB)),
//               ),
          
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(17),
//                 borderSide: BorderSide(color: Color(0xffE5E7EB)),
//               ),
//             ),
//             keyboardType: keyboardType,
//           ),
          
//           Gap(30),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  static const Color _primaryColor = Color(0xFF6D28FF);
  static const Color _labelColor = Color(0xFF5B6475);
  static const Color _fillColor = Color(0xFFF6F3FF);
  static const Color _borderColor = Color(0xFFE5E7EB);

  final String text;
  final String hintText;
  final IconData icon;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;

  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  final bool enabled;

  const EmailField({
    super.key,
    required this.text,
    required this.hintText,
    required this.icon,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.emailAddress,
    this.textInputAction = TextInputAction.next,
    this.autofillHints,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
  });

  OutlineInputBorder _border({
    Color color = _borderColor,
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            height: 1.3,
            fontWeight: FontWeight.w600,
            color: _labelColor,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          autocorrect: false,
          enableSuggestions: false,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontFamily: 'Poppins',
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: _fillColor,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 13,
              fontFamily: 'Poppins',
            ),
            prefixIcon: Icon(
              icon,
              color: _primaryColor,
              size: 20,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 48,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 17,
            ),
            enabledBorder: _border(),
            disabledBorder: _border(),
            focusedBorder: _border(
              color: _primaryColor,
              width: 1.5,
            ),
            errorBorder: _border(
              color: Colors.redAccent,
            ),
            focusedErrorBorder: _border(
              color: Colors.redAccent,
              width: 1.5,
            ),
            errorStyle: const TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }
}