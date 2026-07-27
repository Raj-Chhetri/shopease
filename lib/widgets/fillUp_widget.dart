// import 'package:flutter/material.dart';

// class FillupWidget extends StatelessWidget {
//   final String hintText;
//   final IconData icon;
//   final TextInputType keyboardType;

//   const FillupWidget({
//     super.key,
//     required this.hintText,
//     required this.icon,
//     required this.keyboardType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Color(0xffF6F3FF),
//         contentPadding: EdgeInsets.symmetric(vertical: 20),
//         hint: Text(
//           hintText,
//           style: TextStyle(color: Color(0xFF5B6475), fontSize: 15),
//         ),

//         prefixIcon: Icon(
//           icon,
//           color: Color(0xFF6D28FF),
//         ),

//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(17),
//           borderSide: BorderSide(color: Color(0xffE5E7EB)),
//         ),

//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(17),
//           borderSide: BorderSide(color: Color(0xffE5E7EB)),
//         ),
//       ),
//       keyboardType: keyboardType,
//     );
//   }
// }

import 'package:flutter/material.dart';

class FillupWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool readOnly;
  final VoidCallback? onTap;

  const FillupWidget({
    super.key,
    required this.hintText,
    required this.icon,
    required this.keyboardType,
    this.controller,
    this.textInputAction = TextInputAction.search,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      readOnly: readOnly,
      onTap: onTap,
      style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.brightness == Brightness.dark
            ? const Color(0xFF211D2C)
            : const Color(0xFFF6F3FF),
        hintText: hintText,
        hintStyle: TextStyle(
          color: theme.colorScheme.onSurfaceVariant,
          fontSize: 14,
        ),
        prefixIcon: Icon(icon, color: theme.colorScheme.primary),
        suffixIcon: onClear == null
            ? null
            : IconButton(
                onPressed: onClear,
                tooltip: 'Clear search',
                icon: const Icon(Icons.close_rounded),
              ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }
}
