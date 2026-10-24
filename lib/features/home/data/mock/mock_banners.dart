import '../../../../core/l10n/localized_text.dart';
import '../../../catalogue/data/mock/mock_categories.dart';
import '../models/promo_banner.dart';

const _images = 'assets/images/banners';

const mockBanners = <PromoBanner>[
  PromoBanner(
    id: 'b1',
    title: LocalizedText(en: 'Fashion Sale', ar: 'تخفيضات الأزياء'),
    image: '$_images/fashion_sale.jpg',
    categoryId: CategoryIds.womensFashion,
  ),
  PromoBanner(
    id: 'b2',
    title: LocalizedText(en: "Men's Collection", ar: 'تشكيلة الرجال'),
    image: '$_images/mens_collection.jpg',
    categoryId: CategoryIds.mensFashion,
  ),
  PromoBanner(
    id: 'b3',
    title: LocalizedText(en: 'Smart Deals', ar: 'عروض ذكية'),
    image: '$_images/smart_deals.jpg',
    categoryId: CategoryIds.phones,
  ),
];
