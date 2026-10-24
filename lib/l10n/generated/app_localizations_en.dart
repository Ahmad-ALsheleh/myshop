// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'MyShop';

  @override
  String get appearanceLabel => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageSystem => 'System';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get colorsLabel => 'Colors';

  @override
  String get sampleHeadline => 'Featured';

  @override
  String get getStarted => 'Get Started';

  @override
  String get searchHint => 'What are you looking for?';

  @override
  String get seeAll => 'See All';

  @override
  String get back => 'Back';

  @override
  String get navHome => 'Home';

  @override
  String get navCatalogue => 'Catalogue';

  @override
  String get navFavorite => 'Favorite';

  @override
  String get navProfile => 'Profile';

  @override
  String get openCart => 'Open cart';

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String discountBadge(int percent) {
    return '-$percent%';
  }

  @override
  String ratingLabel(String rating) {
    return 'Rated $rating out of 5';
  }

  @override
  String get addToFavorites => 'Add to favorites';

  @override
  String get removeFromFavorites => 'Remove from favorites';

  @override
  String get increaseQuantity => 'Increase quantity';

  @override
  String get decreaseQuantity => 'Decrease quantity';

  @override
  String get sizesLabel => 'Sizes';

  @override
  String get colorBlack => 'Black';

  @override
  String get colorRed => 'Red';

  @override
  String get colorGreen => 'Green';

  @override
  String get colorBlue => 'Blue';

  @override
  String get colorPurple => 'Purple';

  @override
  String get colorYellow => 'Yellow';

  @override
  String get colorOrange => 'Orange';

  @override
  String get colorBrown => 'Brown';

  @override
  String get colorBeige => 'Beige';

  @override
  String get colorPink => 'Pink';

  @override
  String get colorGray => 'Gray';

  @override
  String get colorWhite => 'White';

  @override
  String get validationRequired => 'This field is required';

  @override
  String validationMinLength(int length) {
    return 'Enter at least $length characters';
  }

  @override
  String validationMaxLength(int length) {
    return 'Enter at most $length characters';
  }

  @override
  String get validationNumber => 'Enter numbers only';

  @override
  String get validationEmail => 'Enter a valid email';

  @override
  String get validationPattern => 'Invalid format';
}
