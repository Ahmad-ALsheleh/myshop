import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product.dart';
import '../../data/models/review.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/repositories/review_repository.dart';

final productProvider = Provider.family<Product?, String>(
  (ref, id) => ref.watch(productRepositoryProvider).getById(id),
);

/// "Products related to this item".
final relatedProductsProvider = Provider.family<List<Product>, String>((
  ref,
  id,
) {
  final repository = ref.watch(productRepositoryProvider);
  final product = repository.getById(id);
  return product == null ? const [] : repository.getRelated(product);
});

final productReviewsProvider = Provider.family<List<Review>, String>(
  (ref, id) => ref.watch(reviewRepositoryProvider).getForProduct(id),
);
