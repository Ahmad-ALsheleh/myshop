import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/data/models/product.dart';
import '../../../product/data/repositories/product_repository.dart';
import '../../data/models/product_filter.dart';

/// Text typed on the search screen.
final searchQueryProvider =
    NotifierProvider.autoDispose<SearchQueryNotifier, String>(
      SearchQueryNotifier.new,
    );

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void update(String query) => state = query;
}

/// Products of every category matching the query (empty without a query).
final searchResultsProvider = Provider.autoDispose<List<Product>>((ref) {
  final query = ref.watch(searchQueryProvider).trim();
  if (query.isEmpty) return const [];
  return ProductFilter(
    query: query,
  ).apply(ref.watch(productRepositoryProvider).getAll());
});
