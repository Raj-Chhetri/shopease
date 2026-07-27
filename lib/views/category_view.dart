// category_view

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/category_controller.dart';

import 'package:shopease/widgets/category_card.dart';
import 'package:shopease/widgets/fillUp_widget.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject and instantiate the controller
    final controller = Get.put(CategoryController());
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Categories',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final horizontalPadding = switch (width) {
              < 360 => 14.0,
              < 700 => 18.0,
              < 1100 => 32.0,
              _ => 48.0,
            };

            final crossAxisCount = switch (width) {
              < 650 => 2,
              < 950 => 3,
              _ => 4,
            };

            return RefreshIndicator(
              onRefresh: controller.loadCategories,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      12,
                      horizontalPadding,
                      110,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FillupWidget(
                                hintText: 'Search products',
                                icon: Icons.search_rounded,
                                keyboardType: TextInputType.text,
                                readOnly: true,
                                onTap: controller.openSearch,
                              ),
                              const SizedBox(height: 26),
                              Text(
                                'All Categories',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Reactive block watching controller updates
                              Obx(() {
                                if (controller.isLoading.value) {
                                  return const SizedBox(
                                    height: 260,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }

                                if (controller.errorMessage.value != null) {
                                  return _CategoryErrorState(
                                    message: controller.errorMessage.value!,
                                    onRetry: controller.loadCategories,
                                  );
                                }

                                if (controller.categories.isEmpty) {
                                  return const _EmptyCategoryState();
                                }

                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.categories.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        childAspectRatio: width < 400
                                            ? 0.88
                                            : 0.95,
                                      ),
                                  itemBuilder: (context, index) {
                                    final category =
                                        controller.categories[index];
                                    final backgroundColor = isDark
                                        ? theme
                                              .colorScheme
                                              .surfaceContainerHighest
                                        : controller.lightCardColors[index %
                                              controller
                                                  .lightCardColors
                                                  .length];

                                    return CategoryCard(
                                      title: category.name,
                                      icon: category.icon,
                                      assetImage:
                                          index <
                                              controller.fallbackAssets.length
                                          ? controller.fallbackAssets[index]
                                          : null,
                                      productCount: category.productCount,
                                      backgroundColor: backgroundColor,
                                      onTap: () =>
                                          controller.openCategory(category),
                                    );
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Private view-only widget states remain grouped with the view
class _CategoryErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _CategoryErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            const Icon(Icons.cloud_off_rounded, size: 52),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}

class _EmptyCategoryState extends StatelessWidget {
  const _EmptyCategoryState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.category_outlined, size: 56),
            SizedBox(height: 12),
            Text('No categories are available'),
          ],
        ),
      ),
    );
  }
}
