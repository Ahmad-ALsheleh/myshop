import '../../../../core/l10n/localized_text.dart';
import '../models/category.dart';

const _images = 'assets/images/categories';

/// Category ids, shared with the product mock data.
abstract final class CategoryIds {
  static const womensFashion = 'womens-fashion';
  static const mensFashion = 'mens-fashion';
  static const phones = 'phones';
  static const computers = 'computers';
  static const smartHome = 'smart-home';
  static const artsCrafts = 'arts-crafts';
  static const baby = 'baby';
  static const sport = 'sport';
}

/// Subcategory ids, shared with the product mock data.
abstract final class SubcategoryIds {
  static const womenDresses = 'women-dresses';
  static const womenTops = 'women-tops';
  static const womenSweaters = 'women-sweaters';
  static const womenJeans = 'women-jeans';
  static const womenSkirts = 'women-skirts';

  static const menShirts = 'men-shirts';
  static const menSweaters = 'men-sweaters';
  static const menJackets = 'men-jackets';
  static const menPants = 'men-pants';

  static const smartphones = 'smartphones';
  static const phoneAccessories = 'phone-accessories';

  static const laptops = 'laptops';
  static const desktops = 'desktops';
  static const computerAccessories = 'computer-accessories';

  static const speakers = 'speakers';
  static const lighting = 'lighting';

  static const painting = 'painting';
  static const crafting = 'crafting';

  static const babyToys = 'baby-toys';
  static const babyClothing = 'baby-clothing';

  static const fitness = 'fitness';
  static const footwear = 'footwear';
}

const mockCategories = <Category>[
  Category(
    id: CategoryIds.womensFashion,
    name: LocalizedText(en: "Women's Fashion", ar: 'أزياء نسائية'),
    image: '$_images/womens_fashion.jpg',
    subcategories: [
      Subcategory(
        id: SubcategoryIds.womenDresses,
        name: LocalizedText(en: 'Dresses', ar: 'فساتين'),
      ),
      Subcategory(
        id: SubcategoryIds.womenTops,
        name: LocalizedText(en: 'Tops', ar: 'بلوزات'),
      ),
      Subcategory(
        id: SubcategoryIds.womenSweaters,
        name: LocalizedText(en: 'Sweaters', ar: 'كنزات'),
      ),
      Subcategory(
        id: SubcategoryIds.womenJeans,
        name: LocalizedText(en: 'Jeans', ar: 'جينز'),
      ),
      Subcategory(
        id: SubcategoryIds.womenSkirts,
        name: LocalizedText(en: 'Skirts', ar: 'تنانير'),
      ),
    ],
  ),
  Category(
    id: CategoryIds.mensFashion,
    name: LocalizedText(en: "Men's Fashion", ar: 'أزياء رجالية'),
    image: '$_images/mens_fashion.jpg',
    subcategories: [
      Subcategory(
        id: SubcategoryIds.menShirts,
        name: LocalizedText(en: 'Shirts', ar: 'قمصان'),
      ),
      Subcategory(
        id: SubcategoryIds.menSweaters,
        name: LocalizedText(en: 'Sweaters', ar: 'كنزات'),
      ),
      Subcategory(
        id: SubcategoryIds.menJackets,
        name: LocalizedText(en: 'Jackets', ar: 'جاكيتات'),
      ),
      Subcategory(
        id: SubcategoryIds.menPants,
        name: LocalizedText(en: 'Pants', ar: 'بناطيل'),
      ),
    ],
  ),
  Category(
    id: CategoryIds.phones,
    name: LocalizedText(en: 'Phones', ar: 'هواتف'),
    image: '$_images/phones.jpg',
    subcategories: [
      Subcategory(
        id: SubcategoryIds.smartphones,
        name: LocalizedText(en: 'Smartphones', ar: 'هواتف ذكية'),
      ),
      Subcategory(
        id: SubcategoryIds.phoneAccessories,
        name: LocalizedText(en: 'Accessories', ar: 'إكسسوارات'),
      ),
    ],
  ),
  Category(
    id: CategoryIds.computers,
    name: LocalizedText(en: 'Computers', ar: 'حواسيب'),
    image: '$_images/computers.jpg',
    subcategories: [
      Subcategory(
        id: SubcategoryIds.laptops,
        name: LocalizedText(en: 'Laptops', ar: 'حواسيب محمولة'),
      ),
      Subcategory(
        id: SubcategoryIds.desktops,
        name: LocalizedText(en: 'Desktops', ar: 'حواسيب مكتبية'),
      ),
      Subcategory(
        id: SubcategoryIds.computerAccessories,
        name: LocalizedText(en: 'Accessories', ar: 'إكسسوارات'),
      ),
    ],
  ),
  Category(
    id: CategoryIds.smartHome,
    name: LocalizedText(en: 'Smart home', ar: 'المنزل الذكي'),
    image: '$_images/smart_home.jpg',
    subcategories: [
      Subcategory(
        id: SubcategoryIds.speakers,
        name: LocalizedText(en: 'Speakers', ar: 'مكبرات صوت'),
      ),
      Subcategory(
        id: SubcategoryIds.lighting,
        name: LocalizedText(en: 'Lighting', ar: 'إضاءة'),
      ),
    ],
  ),
  Category(
    id: CategoryIds.artsCrafts,
    name: LocalizedText(en: 'Arts & Crafts', ar: 'فنون وحِرف'),
    image: '$_images/arts_crafts.jpg',
    subcategories: [
      Subcategory(
        id: SubcategoryIds.painting,
        name: LocalizedText(en: 'Painting', ar: 'رسم وتلوين'),
      ),
      Subcategory(
        id: SubcategoryIds.crafting,
        name: LocalizedText(en: 'Crafting', ar: 'أشغال يدوية'),
      ),
    ],
  ),
  Category(
    id: CategoryIds.baby,
    name: LocalizedText(en: 'Baby', ar: 'الأطفال'),
    image: '$_images/baby.jpg',
    subcategories: [
      Subcategory(
        id: SubcategoryIds.babyToys,
        name: LocalizedText(en: 'Toys', ar: 'ألعاب'),
      ),
      Subcategory(
        id: SubcategoryIds.babyClothing,
        name: LocalizedText(en: 'Clothing', ar: 'ملابس'),
      ),
    ],
  ),
  Category(
    id: CategoryIds.sport,
    name: LocalizedText(en: 'Sport', ar: 'رياضة'),
    image: '$_images/sport.jpg',
    subcategories: [
      Subcategory(
        id: SubcategoryIds.fitness,
        name: LocalizedText(en: 'Fitness', ar: 'لياقة بدنية'),
      ),
      Subcategory(
        id: SubcategoryIds.footwear,
        name: LocalizedText(en: 'Footwear', ar: 'أحذية'),
      ),
    ],
  ),
];
