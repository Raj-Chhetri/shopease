// import 'package:flutter/material.dart';

// Widget filterButton({
//   required IconData icon,
//   required String title,
//   required List<String> options,
// }) {
//   return MenuAnchor(
//     builder: (context, controller, child) {
//       return InkWell(
//         borderRadius: BorderRadius.circular(25),
//         onTap: () {
//           controller.isOpen ? controller.close() : controller.open();
//         },
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(25),
//             boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
//           ),
//           child: Row(
//             children: [
//               Icon(icon, color: Colors.deepPurple, size: 16),

//               const SizedBox(width: 6),

//               Expanded(
//                 child: Text(
//                   title,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),

//               AnimatedRotation(
//                 turns: controller.isOpen ? 0.5 : 0,
//                 duration: const Duration(milliseconds: 200),
//                 child: const Icon(
//                   Icons.keyboard_arrow_down,
//                   color: Colors.deepPurple,
//                   size: 18,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },

//     menuChildren: options.map((option) {
//       return MenuItemButton(
//         onPressed: () {
//           print("$title : $option");
//         },
//         child: Text(option),
//       );
//     }).toList(),
//   );
// }


import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final VoidCallback onPressed;

  const FilterButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final backgroundColor =
        isActive
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.surface;

    final foregroundColor =
        isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 11,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color:
                  isActive
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: theme.colorScheme.primary,
                size: 18,
              ),
              const SizedBox(width: 7),
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: foregroundColor,
                    fontSize: 12,
                    fontWeight:
                        isActive
                            ? FontWeight.w700
                            : FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: theme.colorScheme.primary,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}