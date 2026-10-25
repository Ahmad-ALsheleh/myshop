import '../../../../core/l10n/localized_text.dart';
import '../../../catalogue/data/mock/mock_categories.dart';
import '../models/product.dart';
import '../models/product_color.dart';
import '../models/product_size.dart';

const _images = 'assets/images/products';

// ---------------------------------------------------------------------------
// Women's Fashion (the products that appear in the design)
// ---------------------------------------------------------------------------

const saodimallsuSweater = Product(
  id: 'p1',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenSweaters,
  brand: 'Saodimallsu',
  name: LocalizedText(
    en: 'Saodimallsu Womens Oversized Chunky Knit Long Sleeve Pullover Sweater',
    ar: 'كنزة Saodimallsu نسائية واسعة بأكمام طويلة ونسيج محبوك سميك',
  ),
  description: LocalizedText(
    en:
        'A cozy oversized pullover in a chunky rib knit with long ribbed '
        'cuffs. Its relaxed fit layers easily over a long skirt or wide-leg '
        'trousers all winter long.',
    ar:
        'كنزة واسعة ودافئة بنسيج محبوك سميك وأساور طويلة مضلّعة. قَصّتها '
        'المريحة تجعلها سهلة التنسيق مع تنورة طويلة أو بنطال واسع طوال '
        'الشتاء.',
  ),
  price: 4900,
  oldPrice: 9900,
  images: ['$_images/saodimallsu_sweater.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.beige,
      image: '$_images/saodimallsu_sweater.jpg',
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
    en: 'Astylish Women V-Neck Button Down Long Sleeve Chunky Knit Cardigan',
    ar: 'كارديغان Astylish نسائي محبوك سميك بياقة V وأزرار وأكمام طويلة',
  ),
  description: LocalizedText(
    en:
        "Women's Casual V-Neck Button Down Cardigan with long sleeves and "
        'ribbed cuffs is going to be the newest staple in your wardrobe! '
        'Living up to its namesake, this cardigan is unbelievably soft, warm '
        'and cozy. Layer it over a long dress or pair it with wide-leg '
        'trousers for an effortless everyday look.',
    ar:
        'هذا الكارديغان النسائي الكاجوال بياقته V وأزراره وأكمامه الطويلة '
        'ذات الأساور المضلّعة سيصبح القطعة الأساسية الجديدة في خزانتك! وكما '
        'يوحي اسمه، فهو ناعم ودافئ ومريح بشكل لا يصدق. ارتديه فوق فستان طويل '
        'أو نسّقيه مع بنطال واسع لإطلالة يومية سهلة.',
  ),
  price: 8999,
  // The other colors are the same photo, recolored.
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

const ecowishCardigan = Product(
  id: 'p3',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenSweaters,
  brand: 'ECOWISH',
  name: LocalizedText(
    en: 'ECOWISH Womens Embroidered Leaf Long Knit V-Neck Cardigan',
    ar: 'كارديغان ECOWISH نسائي طويل محبوك بياقة V وتطريز أوراق',
  ),
  description: LocalizedText(
    en:
        'A soft beige cardigan with embroidered leaves and little bobble '
        'flowers. Its long, relaxed fit layers beautifully over dresses and '
        'tunics.',
    ar:
        'كارديغان بيج ناعم بتطريز أوراق وزهور صغيرة بارزة. قَصّته الطويلة '
        'المريحة تجعله مثاليًا فوق الفساتين والتونيكات.',
  ),
  price: 10233,
  images: ['$_images/ecowish_cardigan.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.beige,
      image: '$_images/ecowish_cardigan.jpg',
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
        "Angashion Women's Sweaters Casual Long Sleeve Crewneck Striped "
        'Chunky Knit Pullover',
    ar: 'كنزة Angashion نسائية مخططة بياقة دائرية ونسيج محبوك سميك',
  ),
  description: LocalizedText(
    en:
        'A chunky crewneck pullover with wide navy and gray stripes. The '
        'loose fit and long sleeves keep it warm and comfortable all day.',
    ar:
        'كنزة بياقة دائرية ونسيج محبوك سميك بخطوط عريضة كحلية ورمادية. '
        'قَصّتها الواسعة وأكمامها الطويلة تمنحك الدفء والراحة طوال اليوم.',
  ),
  price: 13298,
  images: ['$_images/angashion_sweater.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.blue,
      image: '$_images/angashion_sweater.jpg',
    ),
  ],
  sizes: [ProductSize.s, ProductSize.m, ProductSize.l, ProductSize.xl],
  rating: 5,
  isFeatured: true,
);

const jouicaCardigan = Product(
  id: 'p5',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenSweaters,
  brand: 'Jouica',
  name: LocalizedText(
    en: "Jouica Women's Lightweight V-Neck Button Front Knit Cardigan",
    ar: 'كارديغان Jouica نسائي خفيف بياقة V وأزرار أمامية',
  ),
  description: LocalizedText(
    en:
        'A lightweight basic cardigan in a soft, fine knit with a V-neck and '
        'a button front. Easy to layer over a blouse or a long dress in every '
        'season.',
    ar:
        'كارديغان أساسي خفيف بنسيج محبوك ناعم وياقة V وأزرار أمامية. سهل '
        'الارتداء فوق بلوزة أو فستان طويل في كل المواسم.',
  ),
  price: 7854,
  images: ['$_images/jouica_cardigan.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.gray,
      image: '$_images/jouica_cardigan.jpg',
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
    en: "Biucly Women's Loose Fit Long Sleeve Pullover Hoodie",
    ar: 'هودي Biucly نسائي واسع بأكمام طويلة',
  ),
  description: LocalizedText(
    en:
        'A soft sage hoodie with a roomy fit, a lined hood and dropped '
        'shoulders, made from a warm brushed fleece for everyday comfort.',
    ar:
        'هودي ناعم بلون أخضر هادئ وقَصّة واسعة وقلنسوة مبطنة وأكتاف منسدلة، '
        'من قماش صوفي دافئ لراحة يومية.',
  ),
  price: 8119,
  images: ['$_images/biucly_hoodie.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.green,
      image: '$_images/biucly_hoodie.jpg',
    ),
  ],
  sizes: [ProductSize.s, ProductSize.m, ProductSize.l],
  rating: 4.5,
);

const voianlimoSweater = Product(
  id: 'p7',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenSweaters,
  brand: 'VOIANLIMO',
  name: LocalizedText(
    en: "VOIANLIMO Women's Color Block Crewneck Knit Sweater",
    ar: 'كنزة VOIANLIMO نسائية محبوكة بياقة دائرية وألوان متباينة',
  ),
  description: LocalizedText(
    en:
        'A bright red knit sweater with a contrasting purple neckline and a '
        'soft brushed texture. A cheerful layer for cold days.',
    ar:
        'كنزة محبوكة باللون الأحمر الزاهي مع ياقة بنفسجية متباينة وملمس '
        'ناعم. قطعة مبهجة للأيام الباردة.',
  ),
  price: 12499,
  images: ['$_images/voianlimo_sweater.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.red,
      image: '$_images/voianlimo_sweater.jpg',
    ),
  ],
  sizes: [ProductSize.xs, ProductSize.s, ProductSize.m, ProductSize.l],
  rating: 4,
);

const simpleeSweater = Product(
  id: 'p8',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenSweaters,
  brand: 'Simplee',
  name: LocalizedText(
    en: "Simplee Women's V-Neck Long Sleeve Ribbed Knit Sweater",
    ar: 'كنزة Simplee نسائية محبوكة بياقة V وأكمام طويلة',
  ),
  description: LocalizedText(
    en:
        'A soft rose sweater in a fine ribbed knit with a V-neck and long '
        'sleeves. Wear it over a shirt or a long-sleeve top.',
    ar:
        'كنزة وردية ناعمة بنسيج محبوك مضلّع وياقة V وأكمام طويلة. ارتديها فوق '
        'قميص أو بلوزة بأكمام طويلة.',
  ),
  price: 10899,
  images: ['$_images/simplee_sweater.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.pink,
      image: '$_images/simplee_sweater.jpg',
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
        "BORIFLORS Women's Long Batwing Sleeve Belted Waist Loose Maxi "
        'Dress',
    ar: 'فستان BORIFLORS نسائي طويل وواسع بأكمام خفاشية وحزام عند الخصر',
  ),
  description: LocalizedText(
    en:
        'A flowing maxi dress with wide batwing sleeves and a belted waist. '
        'The loose, lightweight fabric drapes gracefully for an elegant '
        'evening look.',
    ar:
        'فستان طويل منسدل بأكمام خفاشية واسعة وحزام عند الخصر. قماشه الخفيف '
        'الواسع ينسدل بأناقة لإطلالة مسائية راقية.',
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
    en: "Lark & Ro Women's High Waist Corduroy A-Line Maxi Skirt",
    ar: 'تنورة Lark & Ro نسائية طويلة من المخمل المضلّع بخصر عالٍ',
  ),
  description: LocalizedText(
    en:
        'A long A-line skirt in soft corduroy with a high waist, a button '
        'front and hidden side pockets. Works for the office and the weekend '
        'alike.',
    ar:
        'تنورة طويلة بقَصّة A من المخمل المضلّع الناعم بخصر عالٍ وأزرار '
        'أمامية وجيوب جانبية مخفية. مناسبة للعمل ولعطلة نهاية الأسبوع.',
  ),
  price: 7233,
  images: ['$_images/lark_ro_skirt.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.brown,
      image: '$_images/lark_ro_skirt.jpg',
    ),
  ],
  sizes: [ProductSize.xs, ProductSize.s, ProductSize.m, ProductSize.l],
  rating: 4.5,
);

const larkRoJeans = Product(
  id: 'p11',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenJeans,
  brand: 'Lark & Ro',
  name: LocalizedText(
    en: "Lark & Ro Women's High Rise Relaxed Wide Leg Jeans",
    ar: 'جينز Lark & Ro نسائي واسع بخصر عالٍ',
  ),
  description: LocalizedText(
    en:
        'Relaxed wide-leg jeans in a soft, comfortable denim with a high rise '
        'and a full-length leg.',
    ar: 'بنطال جينز واسع ومريح من قماش دنيم ناعم بخصر عالٍ وطول كامل.',
  ),
  price: 7898,
  images: ['$_images/lark_ro_jeans.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.blue,
      image: '$_images/lark_ro_jeans.jpg',
    ),
  ],
  sizes: ProductSize.values,
  rating: 4,
);

const larkRoMaxiDress = Product(
  id: 'p12',
  categoryId: CategoryIds.womensFashion,
  subcategoryId: SubcategoryIds.womenDresses,
  brand: 'Lark & Ro',
  name: LocalizedText(
    en: "Lark & Ro Women's Long Sleeve Tiered Maxi Dress",
    ar: 'فستان Lark & Ro نسائي طويل بطبقات وأكمام طويلة',
  ),
  description: LocalizedText(
    en:
        'A long tiered dress with full-length sleeves and a wrap-style top in '
        'a soft, flowing fabric. Comfortable for every day, elegant for '
        'family occasions.',
    ar:
        'فستان طويل بطبقات وأكمام طويلة وصدر بتصميم ملفوف، من قماش ناعم '
        'منسدل. مريح للاستخدام اليومي وأنيق للمناسبات العائلية.',
  ),
  price: 8254,
  images: ['$_images/lark_ro_maxi_dress.jpg'],
  colors: [
    ProductColorOption(
      color: ProductColor.brown,
      image: '$_images/lark_ro_maxi_dress.jpg',
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
      color: ProductColor.white,
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
      color: ProductColor.green,
      image: '$_images/nova_phone_green.jpg',
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
      color: ProductColor.orange,
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
  saodimallsuSweater,
  astylishCardigan,
  ecowishCardigan,
  angashionSweater,
  jouicaCardigan,
  biuclyHoodie,
  voianlimoSweater,
  simpleeSweater,
  boriflorsDress,
  larkRoSkirt,
  larkRoJeans,
  larkRoMaxiDress,
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
