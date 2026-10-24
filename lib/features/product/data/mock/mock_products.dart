import '../../../../core/l10n/localized_text.dart';
import '../../../catalogue/data/mock/mock_categories.dart';
import '../models/product.dart';
import '../models/product_color.dart';
import '../models/product_size.dart';

const _images = 'assets/images/products';

// ---------------------------------------------------------------------------
// Women's Fashion (the products that appear in the design)
// ---------------------------------------------------------------------------

const saodimallsuTurtleneck = Product(
  id: 'p1',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenSweaters,
  brand: 'Saodimallsu',
  name: LocalizedText(
    en: 'Saodimallsu Womens Turtleneck Oversized Chunky Knit Pullover Sweater',
    ar: 'كنزة Saodimallsu نسائية واسعة بياقة عالية ونسيج محبوك سميك',
  ),
  description: LocalizedText(
    en:
        'A cozy oversized turtleneck in a chunky waffle knit. Dropped '
        'shoulders and ribbed cuffs make it an easy layer over jeans or '
        'leggings all winter long.',
    ar:
        'كنزة واسعة ودافئة بياقة عالية ونسيج محبوك سميك. أكتافها المنسدلة '
        'وأساورها المضلّعة تجعلها قطعة سهلة التنسيق مع الجينز أو الليغنز طوال '
        'الشتاء.',
  ),
  price: 4900,
  oldPrice: 9900,
  images: ['$_images/saodimallsu_turtleneck.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.beige,
      image: '$_images/saodimallsu_turtleneck.jpg',
    ),
  ],
  sizes: [ProductSize.s, ProductSize.m, ProductSize.l, ProductSize.xl],
  rating: 5,
  isFeatured: true,
);

const astylishCardigan = Product(
  id: 'p2',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenSweaters,
  brand: 'Astylish',
  name: LocalizedText(
    en: 'Astylish Women Open Front Long Sleeve Chunky Knit Cardigan',
    ar: 'كارديغان Astylish نسائي محبوك سميك بأكمام طويلة ومفتوح من الأمام',
  ),
  description: LocalizedText(
    en:
        "Women's Casual V-Neck Pullover Sweater Long Sleeved Sweater Top with "
        'High Low Hemline is going to be the newest staple in your wardrobe! '
        'Living up to its namesake, this sweater is unbelievably soft, '
        'lightweight and stretchy. Pair it with jeans, leggings or a skirt '
        'for an effortless everyday look.',
    ar:
        'هذه الكنزة النسائية الكاجوال بأكمامها الطويلة وحافتها غير المتساوية '
        'ستصبح القطعة الأساسية الجديدة في خزانتك! وكما يوحي اسمها، فهي ناعمة '
        'وخفيفة ومرنة بشكل لا يصدق. نسّقيها مع الجينز أو الليغنز أو التنورة '
        'لإطلالة يومية سهلة.',
  ),
  price: 8999,
  // The other colors only exist as small thumbnails in the design, too
  // blurry for the full-width gallery.
  images: ['$_images/astylish_cardigan_brown.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.brown,
      image: '$_images/astylish_cardigan_brown.jpg',
    ),
    ProductColorOption(
      color: ProductColor.green,
      image: '$_images/astylish_cardigan_green.jpg',
    ),
    ProductColorOption(
      color: ProductColor.pink,
      image: '$_images/astylish_cardigan_pink.jpg',
    ),
    ProductColorOption(
      color: ProductColor.black,
      image: '$_images/astylish_cardigan_black.jpg',
    ),
    ProductColorOption(
      color: ProductColor.beige,
      image: '$_images/astylish_cardigan_beige.jpg',
    ),
    ProductColorOption(
      color: ProductColor.gray,
      image: '$_images/astylish_cardigan_gray.jpg',
    ),
  ],
  sizes: ProductSize.values,
  rating: 5,
  isFeatured: true,
);

const ecowishKimono = Product(
  id: 'p3',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenSweaters,
  brand: 'ECOWISH',
  name: LocalizedText(
    en: 'ECOWISH Womens Color Block Striped Draped Kimono Cardigan',
    ar: 'كارديغان كيمونو ECOWISH نسائي مخطط بألوان متباينة',
  ),
  description: LocalizedText(
    en:
        'A relaxed open-front cardigan with bold color-block stripes and a '
        'soft draped fit. Light enough for spring evenings, warm enough for '
        'autumn days.',
    ar:
        'كارديغان مريح مفتوح من الأمام بخطوط عريضة متباينة الألوان وقَصّة '
        'منسدلة ناعمة. خفيف بما يكفي لأمسيات الربيع ودافئ بما يكفي لأيام '
        'الخريف.',
  ),
  price: 10233,
  images: ['$_images/ecowish_kimono.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.orange,
      image: '$_images/ecowish_kimono.jpg',
    ),
  ],
  sizes: [ProductSize.xs, ProductSize.s, ProductSize.m, ProductSize.l],
  rating: 5,
  isFeatured: true,
);

const angashionSweater = Product(
  id: 'p4',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenSweaters,
  brand: 'Angashion',
  name: LocalizedText(
    en:
        "Angashion Women's Sweaters Casual Long Sleeve Crewneck Color Block "
        'Patchwork Pullover',
    ar: 'كنزة Angashion نسائية كاجوال بياقة دائرية وألوان متداخلة',
  ),
  description: LocalizedText(
    en:
        'A crewneck pullover in three earthy color blocks with a fine knit '
        'texture. The loose fit and long sleeves keep it comfortable all day.',
    ar:
        'كنزة بياقة دائرية بثلاثة ألوان ترابية متداخلة ونسيج محبوك ناعم. '
        'قَصّتها الواسعة وأكمامها الطويلة تمنحك الراحة طوال اليوم.',
  ),
  price: 13298,
  images: ['$_images/angashion_sweater.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.brown,
      image: '$_images/angashion_sweater.jpg',
    ),
  ],
  sizes: [ProductSize.s, ProductSize.m, ProductSize.l, ProductSize.xl],
  rating: 5,
  isFeatured: true,
);

const jouicaSweater = Product(
  id: 'p5',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenSweaters,
  brand: 'Jouica',
  name: LocalizedText(
    en: "Jouica Women's Casual Lightweight V Neck Basic Pullover Sweater",
    ar: 'كنزة Jouica نسائية خفيفة بياقة على شكل V',
  ),
  description: LocalizedText(
    en:
        'A lightweight V-neck basic with a center seam and a soft, slightly '
        'stretchy knit. Tuck it into jeans or wear it loose over leggings.',
    ar:
        'كنزة أساسية خفيفة بياقة V وخياطة في المنتصف ونسيج ناعم مرن قليلًا. '
        'ارتديها داخل الجينز أو بشكل فضفاض فوق الليغنز.',
  ),
  price: 7854,
  images: ['$_images/jouica_sweater.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.brown,
      image: '$_images/jouica_sweater.jpg',
    ),
  ],
  sizes: ProductSize.values,
  rating: 4.5,
);

const biuclyHoodie = Product(
  id: 'p6',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenTops,
  brand: 'Biucly',
  name: LocalizedText(
    en: "Biucly Women's Lightweight Color Block Hoodie Sweatshirt",
    ar: 'هودي Biucly نسائي خفيف بألوان متداخلة',
  ),
  description: LocalizedText(
    en:
        'A breezy knit hoodie with coral and gray stripes and an open-stitch '
        'pattern. A drawstring hood finishes the laid-back look.',
    ar:
        'هودي محبوك خفيف بخطوط مرجانية ورمادية ونقشة مخرّمة، مع قلنسوة '
        'برباط تكمل الإطلالة العفوية.',
  ),
  price: 8119,
  images: ['$_images/biucly_hoodie.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.gray,
      image: '$_images/biucly_hoodie.jpg',
    ),
  ],
  sizes: [ProductSize.s, ProductSize.m, ProductSize.l],
  rating: 4.5,
);

const voianlimoJumper = Product(
  id: 'p7',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenSweaters,
  brand: 'VOIANLIMO',
  name: LocalizedText(
    en: "VOIANLIMO Women's Off Shoulder Knit Jumper Sweater",
    ar: 'كنزة VOIANLIMO نسائية محبوكة بأكتاف مكشوفة',
  ),
  description: LocalizedText(
    en:
        'An off-the-shoulder jumper with batwing sleeves and a waffle knit. '
        'Pair it with skinny jeans and ankle boots.',
    ar:
        'كنزة بأكتاف مكشوفة وأكمام واسعة ونسيج محبوك بنقشة الوافل. نسّقيها مع '
        'جينز ضيق وحذاء بوت قصير.',
  ),
  price: 12499,
  images: ['$_images/voianlimo_jumper.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.green,
      image: '$_images/voianlimo_jumper.jpg',
    ),
  ],
  sizes: [ProductSize.xs, ProductSize.s, ProductSize.m, ProductSize.l],
  rating: 4,
);

const simpleeCardigan = Product(
  id: 'p8',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenSweaters,
  brand: 'Simplee',
  name: LocalizedText(
    en: "Simplee Women's Oversized Lantern Sleeve Knit Cardigan",
    ar: 'كارديغان Simplee نسائي واسع بأكمام منفوخة',
  ),
  description: LocalizedText(
    en:
        'A statement cardigan with puffed lantern sleeves and pom-pom details '
        'in a soft rose knit.',
    ar: 'كارديغان لافت بأكمام منفوخة وتفاصيل كرات صوفية بنسيج وردي ناعم.',
  ),
  price: 10899,
  images: ['$_images/simplee_cardigan.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.pink,
      image: '$_images/simplee_cardigan.jpg',
    ),
  ],
  sizes: [ProductSize.s, ProductSize.m, ProductSize.l],
  rating: 5,
);

const boriflorsDress = Product(
  id: 'p9',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenDresses,
  brand: 'BORIFLORS',
  name: LocalizedText(
    en:
        "BORIFLORS Women's Sexy Wrap Front Long Sleeve Ruched Bodycon Mini "
        'Club Dress',
    ar: 'فستان BORIFLORS نسائي قصير ضيق بأكمام طويلة وتصميم ملفوف من الأمام',
  ),
  description: LocalizedText(
    en:
        'A fitted mini dress with a wrap front, ruched sides and long sleeves. '
        'The stretchy fabric hugs the figure for an elegant evening look.',
    ar:
        'فستان قصير ضيق بتصميم ملفوف من الأمام وكشكشة على الجانبين وأكمام '
        'طويلة. قماشه المرن يبرز القوام لإطلالة مسائية أنيقة.',
  ),
  price: 14999,
  images: ['$_images/boriflors_dress.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.black,
      image: '$_images/boriflors_dress.jpg',
    ),
  ],
  sizes: [ProductSize.xs, ProductSize.s, ProductSize.m, ProductSize.l],
  rating: 4.5,
  isFeatured: true,
);

const larkRoSkirt = Product(
  id: 'p10',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenSkirts,
  brand: 'Lark & Ro',
  name: LocalizedText(
    en: "Lark & Ro Women's High Waist Pleated A-Line Midi Skirt",
    ar: 'تنورة Lark & Ro نسائية متوسطة الطول بخصر عالٍ وثنيات',
  ),
  description: LocalizedText(
    en:
        'A classic pleated midi skirt with a high waist and hidden side '
        'pockets. Works for the office and the weekend alike.',
    ar:
        'تنورة كلاسيكية متوسطة الطول بثنيات وخصر عالٍ وجيوب جانبية مخفية. '
        'مناسبة للعمل ولعطلة نهاية الأسبوع.',
  ),
  price: 4590,
  oldPrice: 6590,
  images: ['$_images/lark_ro_skirt.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.black,
      image: '$_images/lark_ro_skirt.jpg',
    ),
  ],
  sizes: [ProductSize.xs, ProductSize.s, ProductSize.m, ProductSize.l],
  rating: 4.5,
);

const larkRoJeggings = Product(
  id: 'p11',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenJeans,
  brand: 'Lark & Ro',
  name: LocalizedText(
    en: "Lark & Ro Women's Pull-On Stretch Skinny Jeggings",
    ar: 'جينز Lark & Ro نسائي ضيق ومرن بدون أزرار',
  ),
  description: LocalizedText(
    en:
        'Pull-on skinny jeggings with the look of denim and the comfort of '
        'leggings, thanks to a soft high-stretch fabric.',
    ar:
        'بنطال جينز ضيق يُلبس بسهولة، يجمع بين مظهر الجينز وراحة الليغنز '
        'بفضل قماشه الناعم عالي المرونة.',
  ),
  price: 3850,
  images: ['$_images/lark_ro_jeggings.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.black,
      image: '$_images/lark_ro_jeggings.jpg',
    ),
  ],
  sizes: ProductSize.values,
  rating: 4,
);

const larkRoSwingDress = Product(
  id: 'p12',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenDresses,
  brand: 'Lark & Ro',
  name: LocalizedText(
    en: "Lark & Ro Women's Long Sleeve Empire Waist Swing Dress with Pockets",
    ar: 'فستان Lark & Ro نسائي واسع بأكمام طويلة وخصر مرتفع وجيوب',
  ),
  description: LocalizedText(
    en:
        'An easy swing dress with an empire waist, long sleeves and side '
        'pockets in a soft jersey fabric.',
    ar:
        'فستان واسع مريح بخصر مرتفع وأكمام طويلة وجيوب جانبية، من قماش جيرسي '
        'ناعم.',
  ),
  price: 8254,
  images: ['$_images/lark_ro_swing_dress.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.black,
      image: '$_images/lark_ro_swing_dress.jpg',
    ),
  ],
  sizes: [ProductSize.s, ProductSize.m, ProductSize.l, ProductSize.xl],
  rating: 5,
);

// ---------------------------------------------------------------------------
// Other categories (not in the design, a few items each)
// ---------------------------------------------------------------------------

const northfieldOxfordShirt = Product(
  id: 'p13',
  categoryId: CategoryIds.mensFashion,
  subcategoryId: SubcategoryIds.menShirts,
  brand: 'Northfield',
  name: LocalizedText(
    en: "Northfield Men's Slim Fit Oxford Button-Down Shirt",
    ar: 'قميص Northfield رجالي أكسفورد بقَصّة ضيقة',
  ),
  description: LocalizedText(
    en:
        'A crisp cotton Oxford shirt with a button-down collar and a slim '
        'fit that looks sharp with or without a blazer.',
    ar:
        'قميص أكسفورد قطني بياقة بأزرار وقَصّة ضيقة، يبدو أنيقًا مع السترة '
        'أو بدونها.',
  ),
  price: 3499,
  images: ['$_images/northfield_shirt_blue.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.blue,
      image: '$_images/northfield_shirt_blue.jpg',
    ),
    ProductColorOption(
      color: ProductColor.white,
      image: '$_images/northfield_shirt_white.jpg',
    ),
  ],
  sizes: [ProductSize.s, ProductSize.m, ProductSize.l, ProductSize.xl],
  rating: 4.5,
);

const northfieldCableSweater = Product(
  id: 'p14',
  categoryId: CategoryIds.mensFashion,
  subcategoryId: SubcategoryIds.menSweaters,
  brand: 'Northfield',
  name: LocalizedText(
    en: "Northfield Men's Cable Knit Crewneck Sweater",
    ar: 'كنزة Northfield رجالية محبوكة بياقة دائرية',
  ),
  description: LocalizedText(
    en:
        'A warm cable-knit sweater with a ribbed crewneck, cuffs and hem. A '
        'timeless layer for cold days.',
    ar:
        'كنزة دافئة بنقشة الضفائر المحبوكة وياقة وأساور وحافة مضلّعة. قطعة '
        'خالدة للأيام الباردة.',
  ),
  price: 5999,
  images: ['$_images/northfield_sweater.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.gray,
      image: '$_images/northfield_sweater.jpg',
    ),
  ],
  sizes: [ProductSize.m, ProductSize.l, ProductSize.xl],
  rating: 4.5,
);

const urbanThreadDenimJacket = Product(
  id: 'p15',
  categoryId: CategoryIds.mensFashion,
  subcategoryId: SubcategoryIds.menJackets,
  brand: 'Urban Thread',
  name: LocalizedText(
    en: "Urban Thread Men's Classic Denim Trucker Jacket",
    ar: 'جاكيت Urban Thread رجالي جينز كلاسيكي',
  ),
  description: LocalizedText(
    en:
        'A rugged denim jacket with chest pockets and metal buttons that only '
        'gets better with every wear.',
    ar:
        'جاكيت جينز متين بجيوب على الصدر وأزرار معدنية، يزداد جمالًا مع كل '
        'ارتداء.',
  ),
  price: 7950,
  oldPrice: 9950,
  images: ['$_images/urban_thread_jacket.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.blue,
      image: '$_images/urban_thread_jacket.jpg',
    ),
  ],
  sizes: [ProductSize.s, ProductSize.m, ProductSize.l, ProductSize.xl],
  rating: 5,
);

const novaSmartphone = Product(
  id: 'p16',
  categoryId: CategoryIds.phones,
  subcategoryId: SubcategoryIds.smartphones,
  brand: 'Nova',
  name: LocalizedText(
    en: 'Nova X12 Smartphone, 6.1" Display, 128GB',
    ar: 'هاتف Nova X12 الذكي بشاشة 6.1 إنش وسعة 128 جيجابايت',
  ),
  description: LocalizedText(
    en:
        'A bright 6.1-inch OLED display, a dual camera that shines in low '
        'light and a battery that easily lasts the whole day.',
    ar:
        'شاشة OLED ساطعة بقياس 6.1 إنش، وكاميرا مزدوجة تتألق في الإضاءة '
        'المنخفضة، وبطارية تدوم طوال اليوم بسهولة.',
  ),
  price: 69900,
  images: ['$_images/nova_phone_black.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.black,
      image: '$_images/nova_phone_black.jpg',
    ),
    ProductColorOption(
      color: ProductColor.blue,
      image: '$_images/nova_phone_blue.jpg',
    ),
  ],
  rating: 4.5,
  isFeatured: true,
);

const novaEarbuds = Product(
  id: 'p17',
  categoryId: CategoryIds.phones,
  subcategoryId: SubcategoryIds.phoneAccessories,
  brand: 'Nova',
  name: LocalizedText(
    en: 'Nova Wireless Earbuds with Charging Case',
    ar: 'سماعات Nova لاسلكية مع علبة شحن',
  ),
  description: LocalizedText(
    en:
        'True wireless earbuds with clear sound, touch controls and up to 24 '
        'hours of playback with the charging case.',
    ar:
        'سماعات لاسلكية بالكامل بصوت نقي وتحكم باللمس وتشغيل حتى 24 ساعة مع '
        'علبة الشحن.',
  ),
  price: 7999,
  images: ['$_images/nova_earbuds.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.white,
      image: '$_images/nova_earbuds.jpg',
    ),
  ],
  rating: 4,
);

const zentroLaptop = Product(
  id: 'p18',
  categoryId: CategoryIds.computers,
  subcategoryId: SubcategoryIds.laptops,
  brand: 'Zentro',
  name: LocalizedText(
    en: 'Zentro Book 14" Laptop, 16GB RAM, 512GB SSD',
    ar: 'حاسوب Zentro Book محمول 14 إنش بذاكرة 16 جيجابايت وتخزين 512 جيجابايت',
  ),
  description: LocalizedText(
    en:
        'A thin aluminum laptop with a sharp 14-inch screen, fast SSD storage '
        'and a backlit keyboard for working anywhere.',
    ar:
        'حاسوب محمول نحيف من الألمنيوم بشاشة حادة 14 إنش وتخزين SSD سريع '
        'ولوحة مفاتيح مضاءة للعمل من أي مكان.',
  ),
  price: 119900,
  images: ['$_images/zentro_laptop.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.gray,
      image: '$_images/zentro_laptop.jpg',
    ),
  ],
  rating: 4.5,
);

const zentroAllInOne = Product(
  id: 'p19',
  categoryId: CategoryIds.computers,
  subcategoryId: SubcategoryIds.desktops,
  brand: 'Zentro',
  name: LocalizedText(
    en: 'Zentro 24" All-in-One Desktop Computer',
    ar: 'حاسوب Zentro مكتبي متكامل 24 إنش',
  ),
  description: LocalizedText(
    en:
        'A 24-inch all-in-one with a vivid display, built-in speakers and a '
        'wireless keyboard and mouse included.',
    ar:
        'حاسوب متكامل بشاشة 24 إنش زاهية ومكبرات صوت مدمجة، مع لوحة مفاتيح '
        'وفأرة لاسلكيتين.',
  ),
  price: 149900,
  images: ['$_images/zentro_all_in_one.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.white,
      image: '$_images/zentro_all_in_one.jpg',
    ),
  ],
  rating: 5,
);

const homaSmartSpeaker = Product(
  id: 'p20',
  categoryId: CategoryIds.smartHome,
  subcategoryId: SubcategoryIds.speakers,
  brand: 'Homa',
  name: LocalizedText(
    en: 'Homa Mini Smart Speaker with Voice Assistant',
    ar: 'مكبر صوت Homa ذكي صغير مع مساعد صوتي',
  ),
  description: LocalizedText(
    en:
        'A compact speaker with room-filling sound. Ask for music, the '
        'weather or control your smart lights by voice.',
    ar:
        'مكبر صوت صغير بصوت يملأ الغرفة. اطلب الموسيقى أو حالة الطقس أو تحكّم '
        'في أضوائك الذكية بصوتك.',
  ),
  price: 4999,
  images: ['$_images/homa_speaker.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.white,
      image: '$_images/homa_speaker.jpg',
    ),
  ],
  rating: 4.5,
);

const homaSmartBulbs = Product(
  id: 'p21',
  categoryId: CategoryIds.smartHome,
  subcategoryId: SubcategoryIds.lighting,
  brand: 'Homa',
  name: LocalizedText(
    en: 'Homa Color Smart LED Bulbs, 2-Pack',
    ar: 'مصابيح Homa LED ذكية ملونة، عبوة من 2',
  ),
  description: LocalizedText(
    en:
        'Dimmable smart bulbs with 16 million colors, schedules and app or '
        'voice control. No hub required.',
    ar:
        'مصابيح ذكية قابلة للتعتيم بـ16 مليون لون وجداول تشغيل وتحكم عبر '
        'التطبيق أو الصوت، دون الحاجة إلى جهاز وسيط.',
  ),
  price: 2999,
  images: ['$_images/homa_bulbs.jpg'],
  rating: 4,
);

const artifyAcrylicSet = Product(
  id: 'p22',
  categoryId: CategoryIds.artsCrafts,
  subcategoryId: SubcategoryIds.painting,
  brand: 'Artify',
  name: LocalizedText(
    en: 'Artify Acrylic Paint Set, 24 Colors',
    ar: 'مجموعة ألوان أكريليك Artify، 24 لونًا',
  ),
  description: LocalizedText(
    en:
        'Rich, fast-drying acrylic paints for canvas, wood and paper. Great '
        'for beginners and artists alike.',
    ar:
        'ألوان أكريليك غنية وسريعة الجفاف للقماش والخشب والورق، مثالية '
        'للمبتدئين والفنانين على حد سواء.',
  ),
  price: 1899,
  images: ['$_images/artify_acrylic_set.jpg'],
  rating: 5,
);

const artifyEmbroideryKit = Product(
  id: 'p23',
  categoryId: CategoryIds.artsCrafts,
  subcategoryId: SubcategoryIds.crafting,
  brand: 'Artify',
  name: LocalizedText(
    en: 'Artify DIY Embroidery Starter Kit',
    ar: 'مجموعة Artify لتعلّم التطريز للمبتدئين',
  ),
  description: LocalizedText(
    en:
        'Everything you need to start embroidering: hoops, threads, needles '
        'and three printed floral patterns.',
    ar:
        'كل ما تحتاجه لبدء التطريز: أطواق وخيوط وإبر وثلاثة تصاميم زهور '
        'مطبوعة.',
  ),
  price: 2450,
  images: ['$_images/artify_embroidery_kit.jpg'],
  rating: 4.5,
);

const tinyStepsPlushSet = Product(
  id: 'p24',
  categoryId: CategoryIds.baby,
  subcategoryId: SubcategoryIds.babyToys,
  brand: 'Tiny Steps',
  name: LocalizedText(
    en: 'Tiny Steps Soft Plush Activity Toy Set',
    ar: 'مجموعة ألعاب Tiny Steps قطنية ناعمة للأنشطة',
  ),
  description: LocalizedText(
    en:
        'Colorful plush toys with rattles, crinkly ears and different '
        'textures to keep little hands busy.',
    ar:
        'ألعاب قطنية ملونة بخشخيشات وآذان مقرمشة وملمس متنوع لتبقى الأيدي '
        'الصغيرة مشغولة.',
  ),
  price: 2799,
  images: ['$_images/tiny_steps_plush.jpg'],
  rating: 5,
);

const tinyStepsBodysuits = Product(
  id: 'p25',
  categoryId: CategoryIds.baby,
  subcategoryId: SubcategoryIds.babyClothing,
  brand: 'Tiny Steps',
  name: LocalizedText(
    en: 'Tiny Steps Organic Cotton Baby Bodysuits, 5-Pack',
    ar: 'بدلات Tiny Steps للأطفال من القطن العضوي، عبوة من 5',
  ),
  description: LocalizedText(
    en:
        'Soft organic cotton bodysuits with snap closures for quick, easy '
        'changes.',
    ar: 'بدلات ناعمة من القطن العضوي بأزرار كبس لتغيير سريع وسهل.',
  ),
  price: 2499,
  images: ['$_images/tiny_steps_bodysuits.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.white,
      image: '$_images/tiny_steps_bodysuits.jpg',
    ),
  ],
  rating: 4.5,
);

const strideYogaMat = Product(
  id: 'p26',
  categoryId: CategoryIds.sport,
  subcategoryId: SubcategoryIds.fitness,
  brand: 'Stride',
  name: LocalizedText(
    en: 'Stride Non-Slip Yoga Mat, 6 mm',
    ar: 'سجادة يوغا Stride مانعة للانزلاق، 6 مم',
  ),
  description: LocalizedText(
    en:
        'A cushioned, non-slip mat with a carrying strap, for yoga, pilates '
        'and home workouts.',
    ar:
        'سجادة مبطنة مانعة للانزلاق مع حزام للحمل، لليوغا والبيلاتس والتمارين '
        'المنزلية.',
  ),
  price: 2999,
  images: ['$_images/stride_yoga_mat_purple.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.purple,
      image: '$_images/stride_yoga_mat_purple.jpg',
    ),
    ProductColorOption(
      color: ProductColor.blue,
      image: '$_images/stride_yoga_mat_blue.jpg',
    ),
  ],
  rating: 4.5,
);

const strideRunningShoes = Product(
  id: 'p27',
  categoryId: CategoryIds.sport,
  subcategoryId: SubcategoryIds.footwear,
  brand: 'Stride',
  name: LocalizedText(
    en: "Stride Men's Lightweight Running Shoes",
    ar: 'حذاء Stride رجالي خفيف للجري',
  ),
  description: LocalizedText(
    en:
        'Breathable mesh running shoes with a cushioned sole that keeps every '
        'stride light and comfortable.',
    ar: 'حذاء جري من الشبك المسامي بنعل مبطن يجعل كل خطوة خفيفة ومريحة.',
  ),
  price: 6499,
  images: ['$_images/stride_running_shoes.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.black,
      image: '$_images/stride_running_shoes.jpg',
    ),
  ],
  rating: 4,
);

/// In "Featured" order (the default sort).
const mockProducts = <Product>[
  saodimallsuTurtleneck,
  astylishCardigan,
  ecowishKimono,
  angashionSweater,
  jouicaSweater,
  biuclyHoodie,
  voianlimoJumper,
  simpleeCardigan,
  boriflorsDress,
  larkRoSkirt,
  larkRoJeggings,
  larkRoSwingDress,
  northfieldOxfordShirt,
  northfieldCableSweater,
  urbanThreadDenimJacket,
  novaSmartphone,
  novaEarbuds,
  zentroLaptop,
  zentroAllInOne,
  homaSmartSpeaker,
  homaSmartBulbs,
  artifyAcrylicSet,
  artifyEmbroideryKit,
  tinyStepsPlushSet,
  tinyStepsBodysuits,
  strideYogaMat,
  strideRunningShoes,
];
