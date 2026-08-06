// import 'package:flutter/material.dart';

// class OtpField extends StatelessWidget {
//   final TextEditingController controller;
//   final FocusNode currentfocus;
//   final FocusNode? previousfocus;
//   final FocusNode? nextfocus;
//   const OtpField({
//     required this.currentfocus,
//     this.previousfocus,
//     this.nextfocus,
//     required this.controller,
//     super.key,

//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 50,
//       child: TextField(
//         controller: controller,
//         focusNode: currentfocus,
//         textAlign: TextAlign.center,
//         maxLength: 1,
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//           counterText: "",
//           enabledBorder: UnderlineInputBorder(),
//           focusedBorder: UnderlineInputBorder()
//         ),
        
//         onChanged: (value) {
//            if (value.length == 1 && nextfocus != null) {
//                 FocusScope.of(context).requestFocus(nextfocus);
//                  }

//            if (value.isEmpty && previousfocus != null) {
//               FocusScope.of(context).requestFocus(previousfocus);
//               }
//           },

//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpField extends StatelessWidget {
  static const Color _primaryColor = Color(0xFF6D28FF);
  static const Color _borderColor = Color(0xFFD1D5DB);
  static const Color _fillColor = Color(0xFFF8F7FF);

  final TextEditingController controller;
  final FocusNode currentFocus;
  final FocusNode? previousFocus;
  final FocusNode? nextFocus;

  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onPaste;

  const OtpField({
    super.key,
    required this.controller,
    required this.currentFocus,
    this.previousFocus,
    this.nextFocus,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.onPaste,
  });

  OutlineInputBorder _border({
    required Color color,
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 58,
      child: TextFormField(
        controller: controller,
        focusNode: currentFocus,
        autofocus: autofocus,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textInputAction:
            nextFocus == null ? TextInputAction.done : TextInputAction.next,
        autofillHints: const [
          AutofillHints.oneTimeCode,
        ],
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        style: const TextStyle(
          fontSize: 22,
          height: 1,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: _fillColor,
          contentPadding: EdgeInsets.zero,
          enabledBorder: _border(
            color: _borderColor,
          ),
          focusedBorder: _border(
            color: _primaryColor,
            width: 1.6,
          ),
        ),
        onChanged: (value) {
          onChanged?.call(value);
        },
        onFieldSubmitted: onSubmitted,
        contextMenuBuilder: (context, editableTextState) {
          return AdaptiveTextSelectionToolbar.editableText(
            editableTextState: editableTextState,
          );
        },
      ),
    );
  }
}