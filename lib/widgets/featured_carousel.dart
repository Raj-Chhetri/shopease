import 'package:flutter/material.dart';
import 'package:shopease/models/featured_item.dart';
import 'package:shopease/theme/app_theme.dart';
import 'package:shopease/widgets/featured_card.dart';

class FeaturedCarousel extends StatelessWidget {
  final PageController controller;
  final List<FeaturedItem> items;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onProductPressed;

  const FeaturedCarousel({
    super.key,
    required this.controller,
    required this.items,
    required this.currentPage,
    required this.onPageChanged,
    required this.onProductPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 205,
          child: PageView.builder(
            controller: controller,
            itemCount: items.length,
            onPageChanged: onPageChanged,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = items[index];
              final selected = index == currentPage;

              return AnimatedPadding(
                duration: const Duration(milliseconds: 220),
                padding: EdgeInsets.only(
                  right: 12,
                  top: selected ? 0 : 7,
                  bottom: selected ? 0 : 7,
                ),
                child: FeaturedCard(
                  imageUrl: item.imageUrl,
                  title: item.title,
                  subtitle: item.subtitle,
                  onTap: () => onProductPressed(item.productId),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(items.length, (index) {
            final selected = index == currentPage;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: selected ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: selected
                    ? AppTheme.primary
                    : Theme.of(context).colorScheme.outline,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }),
        ),
      ],
    );
  }
}
