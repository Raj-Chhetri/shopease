// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';

// ValueNotifier<bool> showPassword = ValueNotifier(false);

// class PasswordFieldWidget extends StatefulWidget {
//   final String text;
//   final String hintText;
//   const PasswordFieldWidget({
//     required this.text,
//     required this.hintText,
//     super.key,
//   });

//   @override
//   State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
// }

// class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.text,
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
//                 widget.hintText,
//                 style: TextStyle(color: Color(0xFF5B6475), fontSize: 15),
//               ),

//               prefixIcon: Icon(
//                 Icons.lock, 
//                 color: Color(0xFF6D28FF)
//               ),

//               suffixIcon: IconButton(
//                 onPressed: () {
//                   setState(() {
                    
//                   });
//                   showPassword.value = !showPassword.value;
//                 },
//                 icon: ValueListenableBuilder(
//                   valueListenable: showPassword,
//                   builder: (context, value, child) {
//                     return Icon(value ? Icons.visibility : Icons.visibility_off);  
//                   },
//                 ),
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
//             keyboardType: TextInputType.text,
//             obscureText: !showPassword.value,
//           ),
//           Gap(30),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class PasswordFieldWidget extends StatefulWidget {
  final String text;
  final String hintText;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;

  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  final bool enabled;

  const PasswordFieldWidget({
    super.key,
    required this.text,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.autofillHints,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
  });

  @override
  State<PasswordFieldWidget> createState() =>
      _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  static const Color _primaryColor = Color(0xFF6D28FF);
  static const Color _labelColor = Color(0xFF5B6475);
  static const Color _fillColor = Color(0xFFF6F3FF);
  static const Color _borderColor = Color(0xFFE5E7EB);

  bool _isPasswordVisible = false;

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

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
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
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          obscureText: !_isPasswordVisible,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: widget.textInputAction,
          autofillHints: widget.autofillHints,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
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
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 13,
              fontFamily: 'Poppins',
            ),
            prefixIcon: const Icon(
              Icons.lock_rounded,
              color: _primaryColor,
              size: 20,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 48,
            ),
            suffixIcon: IconButton(
              onPressed: widget.enabled
                  ? _togglePasswordVisibility
                  : null,
              tooltip: _isPasswordVisible
                  ? 'Hide password'
                  : 'Show password',
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  );
                },
                child: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  key: ValueKey(_isPasswordVisible),
                  color: const Color(0xFF111827),
                  size: 20,
                ),
              ),
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