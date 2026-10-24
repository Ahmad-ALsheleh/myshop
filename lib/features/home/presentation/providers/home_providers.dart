import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/data/models/product.dart';
import '../../../product/data/repositories/product_repository.dart';
import '../../data/models/promo_banner.dart';
import '../../data/repositories/banner_repository.dart';

final bannersProvider = Provider<List<PromoBanner>>(
  (ref) => ref.watch(bannerRepositoryProvider).getAll(),
);

final featuredProductsProvider = Provider<List<Product>>(
  (ref) => ref.watch(productRepositoryProvider).getFeatured(),
);
