import 'package:get/get.dart';

class FilterController extends GetxController {
  int? selectedCategoryId;
  String? selectedCategoryName;

  double? minimumPrice;
  double? maximumPrice;

  bool get hasActiveFilters {
    return selectedCategoryId != null ||
        minimumPrice != null ||
        maximumPrice != null;
  }

  void selectCategory({
    required int? id,
    required String? name,
  }) {
    selectedCategoryId = id;
    selectedCategoryName = name;
    update();
  }

  void selectPriceRange({
    required double? minimum,
    required double? maximum,
  }) {
    minimumPrice = minimum;
    maximumPrice = maximum;
    update();
  }

  void clearCategory() {
    selectedCategoryId = null;
    selectedCategoryName = null;
    update();
  }

  void clearPrice() {
    minimumPrice = null;
    maximumPrice = null;
    update();
  }

  void clearAllFilters() {
    selectedCategoryId = null;
    selectedCategoryName = null;
    minimumPrice = null;
    maximumPrice = null;
    update();
  }

  Map<String, dynamic> buildQueryParameters({
    String? searchQuery,
    int page = 1,
  }) {
    final query = <String, dynamic>{
      'page': page,
    };

    final trimmedSearch = searchQuery?.trim() ?? '';

    if (trimmedSearch.isNotEmpty) {
      query['q'] = trimmedSearch;
    }

    if (selectedCategoryId != null) {
      // The collection shows both:
      // category_id=1
      // category=footwear
      //
      // category_id is safer when selecting a category
      // returned by GET /api/categories.
      query['category_id'] = selectedCategoryId;
    }

    if (minimumPrice != null) {
      query['min_price'] = minimumPrice;
    }

    if (maximumPrice != null) {
      query['max_price'] = maximumPrice;
    }

    return query;
  }
}
