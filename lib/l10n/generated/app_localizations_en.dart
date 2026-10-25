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
  String get getStarted => 'Get Started';

  @override
  String get onboardingSubtitle =>
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry';

  @override
  String get phoneTitle => 'What Is Your Phone\nNumber?';

  @override
  String get phoneSubtitle =>
      'Please enter your phone number to verify your account';

  @override
  String get sendVerificationCode => 'Send Verification Code';

  @override
  String get skip => 'Skip';

  @override
  String get selectCountry => 'Select country';

  @override
  String get verificationTitle => 'Verification\nCode';

  @override
  String get verificationSubtitle => 'Please enter Code sent to';

  @override
  String get changePhoneNumber => 'Change Phone Number';

  @override
  String get resendCode => 'Resend Code';

  @override
  String get codeResent => 'A new code has been sent';

  @override
  String get invalidCode => 'The code is not correct';

  @override
  String get validationPhone => 'Enter a valid phone number';

  @override
  String get validationCode => 'Enter the 4-digit code';

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

  @override
  String get featured => 'Featured';

  @override
  String get seeMore => 'See More';

  @override
  String get menu => 'Menu';

  @override
  String get notifications => 'Notifications';

  @override
  String get noNotifications => 'You have no new notifications';

  @override
  String get filter => 'Filter';

  @override
  String get all => 'All';

  @override
  String get sortBy => 'Sort by:';

  @override
  String get sortFeatured => 'Featured';

  @override
  String get sortPriceLowToHigh => 'Price: lowest to high';

  @override
  String get sortPriceHighToLow => 'Price: highest to low';

  @override
  String get sortTopRated => 'Top rated';

  @override
  String get noProducts => 'No products found';

  @override
  String get searchPrompt => 'Type to search all products';

  @override
  String get search => 'Search';

  @override
  String get noFavorites => 'No favorites yet';

  @override
  String get guest => 'Guest';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get shippingAddresses => 'Shipping Addresses';

  @override
  String get paymentMethods => 'Payment Methods';

  @override
  String get orders => 'Orders';

  @override
  String get settings => 'Settings';

  @override
  String get logOut => 'Log Out';

  @override
  String get signIn => 'Sign In';

  @override
  String get logOutConfirm => 'Do you want to log out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get privacyPolicyBody =>
      'MyShop is a demo app: your data never leaves this device. The phone number and settings you enter are only stored locally to keep you signed in.';
}
