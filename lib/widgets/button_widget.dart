import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final Color color;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? iconColor;

  const ButtonWidget({
    super.key,
    required this.buttonText,
    required this.backgroundColor,
    required this.color,
    required this.onPressed,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 60),
              backgroundColor: backgroundColor,
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(15),
              ),
              elevation: 0,
              
            ),
            onPressed: onPressed,
            //icon: Icon(
             // icon,
            //  color: iconColor,
            //),
            label: Text(
              buttonText,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color:color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
