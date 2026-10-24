import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mock/mock_banners.dart';
import '../models/promo_banner.dart';

final bannerRepositoryProvider = Provider<BannerRepository>(
  (ref) => BannerRepository(),
);

class BannerRepository {
  List<PromoBanner> getAll() => mockBanners;
}
