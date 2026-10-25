// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'MyShop';

  @override
  String get appearanceLabel => 'المظهر';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get languageLabel => 'اللغة';

  @override
  String get languageSystem => 'النظام';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get colorsLabel => 'الألوان';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get onboardingSubtitle =>
      'لوريم إيبسوم هو ببساطة نص شكلي يُستخدم في صناعة الطباعة والتنضيد';

  @override
  String get phoneTitle => 'ما هو رقم\nهاتفك؟';

  @override
  String get phoneSubtitle => 'يرجى إدخال رقم هاتفك للتحقق من حسابك';

  @override
  String get sendVerificationCode => 'إرسال رمز التحقق';

  @override
  String get skip => 'تخطي';

  @override
  String get selectCountry => 'اختر الدولة';

  @override
  String get verificationTitle => 'رمز\nالتحقق';

  @override
  String get verificationSubtitle => 'يرجى إدخال الرمز المرسل إلى';

  @override
  String get changePhoneNumber => 'تغيير رقم الهاتف';

  @override
  String get resendCode => 'إعادة إرسال الرمز';

  @override
  String get codeResent => 'تم إرسال رمز جديد';

  @override
  String get invalidCode => 'الرمز غير صحيح';

  @override
  String get validationPhone => 'أدخل رقم هاتف صحيحًا';

  @override
  String get validationCode => 'أدخل الرمز المكون من 4 أرقام';

  @override
  String get searchHint => 'عمّ تبحث؟';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get back => 'رجوع';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navCatalogue => 'الأقسام';

  @override
  String get navFavorite => 'المفضلة';

  @override
  String get navProfile => 'حسابي';

  @override
  String get openCart => 'فتح السلة';

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count منتج',
      many: '$count منتجًا',
      few: '$count منتجات',
      two: 'منتجان',
      one: 'منتج واحد',
      zero: 'لا منتجات',
    );
    return '$_temp0';
  }

  @override
  String discountBadge(int percent) {
    return '-$percent%';
  }

  @override
  String ratingLabel(String rating) {
    return 'التقييم $rating من 5';
  }

  @override
  String get addToFavorites => 'إضافة إلى المفضلة';

  @override
  String get removeFromFavorites => 'إزالة من المفضلة';

  @override
  String get increaseQuantity => 'زيادة الكمية';

  @override
  String get decreaseQuantity => 'إنقاص الكمية';

  @override
  String get sizesLabel => 'المقاسات';

  @override
  String get colorBlack => 'أسود';

  @override
  String get colorRed => 'أحمر';

  @override
  String get colorGreen => 'أخضر';

  @override
  String get colorBlue => 'أزرق';

  @override
  String get colorPurple => 'بنفسجي';

  @override
  String get colorYellow => 'أصفر';

  @override
  String get colorOrange => 'برتقالي';

  @override
  String get colorBrown => 'بني';

  @override
  String get colorBeige => 'بيج';

  @override
  String get colorPink => 'وردي';

  @override
  String get colorGray => 'رمادي';

  @override
  String get colorWhite => 'أبيض';

  @override
  String get validationRequired => 'هذا الحقل مطلوب';

  @override
  String validationMinLength(int length) {
    return 'أدخل $length أحرف على الأقل';
  }

  @override
  String validationMaxLength(int length) {
    return 'أدخل $length أحرف كحد أقصى';
  }

  @override
  String get validationNumber => 'أدخل أرقامًا فقط';

  @override
  String get validationEmail => 'أدخل بريدًا إلكترونيًا صحيحًا';

  @override
  String get validationPattern => 'الصيغة غير صحيحة';

  @override
  String get featured => 'مميز';

  @override
  String get seeMore => 'عرض المزيد';

  @override
  String get menu => 'القائمة';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get noNotifications => 'لا توجد إشعارات جديدة';

  @override
  String get filter => 'الفلتر';

  @override
  String get all => 'الكل';

  @override
  String get sortBy => 'ترتيب حسب:';

  @override
  String get sortFeatured => 'المميزة';

  @override
  String get sortPriceLowToHigh => 'السعر: من الأقل إلى الأعلى';

  @override
  String get sortPriceHighToLow => 'السعر: من الأعلى إلى الأقل';

  @override
  String get sortTopRated => 'الأعلى تقييمًا';

  @override
  String get noProducts => 'لا توجد منتجات';

  @override
  String get searchPrompt => 'اكتب للبحث في كل المنتجات';

  @override
  String get search => 'البحث';

  @override
  String get noFavorites => 'لا توجد منتجات مفضلة بعد';

  @override
  String get guest => 'زائر';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get shippingAddresses => 'عناوين الشحن';

  @override
  String get paymentMethods => 'طرق الدفع';

  @override
  String get orders => 'الطلبات';

  @override
  String get settings => 'الإعدادات';

  @override
  String get logOut => 'تسجيل الخروج';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get logOutConfirm => 'هل تريد تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get privacyPolicyBody =>
      'MyShop تطبيق تجريبي: بياناتك لا تغادر هذا الجهاز. رقم الهاتف والإعدادات التي تدخلها تُحفظ محليًا فقط لإبقائك مسجلًا للدخول.';

  @override
  String get clear => 'مسح';

  @override
  String get priceLabel => 'السعر';

  @override
  String get categoriesLabel => 'الأقسام';

  @override
  String get brandLabel => 'الماركة';

  @override
  String get sortByLabel => 'ترتيب حسب';

  @override
  String results(int count) {
    return 'النتائج ($count)';
  }

  @override
  String get priceRangeInvalid => 'يجب ألا يكون أقل سعر أعلى من أعلى سعر';

  @override
  String reviewsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تقييم',
      many: '$count تقييمًا',
      few: '$count تقييمات',
      two: 'تقييمان',
      one: 'تقييم واحد',
      zero: 'لا تقييمات',
    );
    return '$_temp0';
  }

  @override
  String get inStock => 'متوفر';

  @override
  String get outOfStock => 'غير متوفر';

  @override
  String get productDetails => 'تفاصيل المنتج';

  @override
  String get reviews => 'التقييمات';

  @override
  String helpfulCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count شخص وجدوا هذا مفيدًا',
      many: '$count شخصًا وجدوا هذا مفيدًا',
      few: '$count أشخاص وجدوا هذا مفيدًا',
      two: 'شخصان وجدا هذا مفيدًا',
      one: 'شخص واحد وجد هذا مفيدًا',
    );
    return '$_temp0';
  }

  @override
  String get comment => 'تعليق';

  @override
  String get helpful => 'مفيد';

  @override
  String get relatedProducts => 'منتجات ذات صلة بهذا المنتج';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String get addedToCart => 'تمت الإضافة إلى السلة';

  @override
  String get viewCart => 'عرض السلة';

  @override
  String get writeComment => 'اكتب تعليقك';

  @override
  String get send => 'إرسال';

  @override
  String get commentThanks => 'شكرًا على تعليقك!';

  @override
  String get showMore => 'عرض المزيد';

  @override
  String get showLess => 'عرض أقل';

  @override
  String get cart => 'السلة';

  @override
  String get delete => 'حذف';

  @override
  String get clearCartConfirm => 'هل تريد إزالة كل المنتجات من السلة؟';

  @override
  String get totalPrice => 'السعر الإجمالي';

  @override
  String get checkOut => 'إتمام الشراء';

  @override
  String get emptyCart => 'سلتك فارغة';

  @override
  String get shippingAddress => 'عنوان الشحن';

  @override
  String get deliveryMethod => 'طريقة التوصيل';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get change => 'تغيير';

  @override
  String get itemsLabel => 'المنتجات';

  @override
  String get deliveryLabel => 'التوصيل';

  @override
  String get pay => 'ادفع';

  @override
  String deliveryDays(int min, int max) {
    return '$min-$max أيام';
  }

  @override
  String get success => 'تم بنجاح';

  @override
  String get orderSuccessMessage =>
      'سيتم توصيل طلبك قريبًا.\nيمكنك متابعته من قسم \"الطلبات\".';

  @override
  String get continueShopping => 'متابعة التسوق';

  @override
  String get goToOrders => 'الذهاب إلى الطلبات';

  @override
  String get noAddress => 'أضف عنوان شحن من ملفك الشخصي';

  @override
  String get noCard => 'أضف بطاقة دفع من ملفك الشخصي';

  @override
  String orderNumber(String number) {
    return 'الطلب رقم $number';
  }

  @override
  String get orderProcessing => 'قيد التجهيز';

  @override
  String get orderShipped => 'تم الشحن';

  @override
  String get orderDelivered => 'تم التوصيل';

  @override
  String get noOrders => 'لا توجد طلبات بعد';

  @override
  String get done => 'تم';

  @override
  String get addAddress => 'إضافة عنوان';

  @override
  String get editAddress => 'تعديل العنوان';

  @override
  String get fullNameLabel => 'الاسم الكامل';

  @override
  String get streetLabel => 'الشارع والرقم';

  @override
  String get cityLabel => 'المدينة';

  @override
  String get regionLabel => 'الولاية / المنطقة';

  @override
  String get zipCodeLabel => 'الرمز البريدي';

  @override
  String get countryLabel => 'الدولة';

  @override
  String get setAsDefault => 'استخدامه كافتراضي';

  @override
  String get defaultBadge => 'افتراضي';

  @override
  String get save => 'حفظ';

  @override
  String get edit => 'تعديل';

  @override
  String get deleteAddressConfirm => 'هل تريد حذف هذا العنوان؟';

  @override
  String get noAddresses => 'لا توجد عناوين محفوظة';

  @override
  String get addCard => 'إضافة بطاقة';

  @override
  String get cardNumberLabel => 'رقم البطاقة';

  @override
  String get cardHolderLabel => 'الاسم على البطاقة';

  @override
  String get expiryLabel => 'تاريخ الانتهاء (MM/YY)';

  @override
  String get cvvLabel => 'رمز CVV';

  @override
  String get validationCardNumber => 'أدخل رقم بطاقة Visa أو Mastercard صحيحًا';

  @override
  String get validationExpiry => 'أدخل تاريخًا صحيحًا في المستقبل';

  @override
  String get validationCvv => 'أدخل الأرقام الثلاثة على ظهر البطاقة';

  @override
  String get deleteCardConfirm => 'هل تريد حذف هذه البطاقة؟';

  @override
  String get noCards => 'لا توجد بطاقات محفوظة';

  @override
  String expires(String date) {
    return 'تنتهي في $date';
  }

  @override
  String get nameLabel => 'الاسم';
}
