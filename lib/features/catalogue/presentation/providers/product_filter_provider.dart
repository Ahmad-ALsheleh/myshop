import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/data/models/product_sort.dart';
import '../../data/models/product_filter.dart';

/// Filter of the items screen, one per category id.
///
/// Auto-disposed: leaving the items screen resets its filter. The filter
/// screen is pushed on top of the items screen, so the state stays alive
/// while the user is editing it.
final productFilterProvider = NotifierProvider.autoDispose
    .family<ProductFilterNotifier, ProductFilter, String>(
      (_) => ProductFilterNotifier(),
    );

class ProductFilterNotifier extends Notifier<ProductFilter> {
  @override
  ProductFilter build() => const ProductFilter();

  void search(String query) => state = state.copyWith(query: query);

  /// `null` selects the "All" chip.
  void selectSubcategory(String? subcategoryId) =>
      state = state.copyWith(subcategoryId: () => subcategoryId);

  void sortBy(ProductSort sort) => state = state.copyWith(sort: sort);

  /// Applies the draft edited on the filter screen ("Results" button).
  /// The search text typed on the items screen is kept.
  void apply(ProductFilter filter) =>
      state = filter.copyWith(query: state.query);
}
