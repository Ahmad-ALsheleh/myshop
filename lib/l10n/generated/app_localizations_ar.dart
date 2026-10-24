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
  String get sampleHeadline => 'مميز';

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
}
