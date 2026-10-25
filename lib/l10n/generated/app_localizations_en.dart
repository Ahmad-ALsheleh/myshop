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

  @override
  String get clear => 'Clear';

  @override
  String get priceLabel => 'Price';

  @override
  String get categoriesLabel => 'Categories';

  @override
  String get brandLabel => 'Brand';

  @override
  String get sortByLabel => 'Sort by';

  @override
  String results(int count) {
    return 'Results ($count)';
  }

  @override
  String get priceRangeInvalid =>
      'The minimum price must not be higher than the maximum';

  @override
  String reviewsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reviews',
      one: '1 review',
    );
    return '$_temp0';
  }

  @override
  String get inStock => 'In Stock';

  @override
  String get outOfStock => 'Out of Stock';

  @override
  String get productDetails => 'Product details';

  @override
  String get reviews => 'Reviews';

  @override
  String helpfulCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count people found this helpful',
      one: '1 person found this helpful',
    );
    return '$_temp0';
  }

  @override
  String get comment => 'Comment';

  @override
  String get helpful => 'Helpful';

  @override
  String get relatedProducts => 'Products related to this item';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get addedToCart => 'Added to cart';

  @override
  String get viewCart => 'View cart';

  @override
  String get writeComment => 'Write your comment';

  @override
  String get send => 'Send';

  @override
  String get commentThanks => 'Thanks for your comment!';

  @override
  String get showMore => 'Show more';

  @override
  String get showLess => 'Show less';

  @override
  String get cart => 'Cart';

  @override
  String get delete => 'Delete';

  @override
  String get clearCartConfirm => 'Remove all items from the cart?';

  @override
  String get totalPrice => 'Total price';

  @override
  String get checkOut => 'Check Out';

  @override
  String get emptyCart => 'Your cart is empty';

  @override
  String get shippingAddress => 'Shipping Address';

  @override
  String get deliveryMethod => 'Delivery Method';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get change => 'Change';

  @override
  String get itemsLabel => 'Items';

  @override
  String get deliveryLabel => 'Delivery';

  @override
  String get pay => 'Pay';

  @override
  String deliveryDays(int min, int max) {
    return '$min-$max days';
  }

  @override
  String get success => 'Success';

  @override
  String get orderSuccessMessage =>
      'Your order will be delivered soon.\nIt can be tracked in the \"Orders\" section.';

  @override
  String get continueShopping => 'Continue Shopping';

  @override
  String get goToOrders => 'Go to Orders';

  @override
  String get noAddress => 'Add a shipping address in your profile';

  @override
  String get noCard => 'Add a payment card in your profile';

  @override
  String orderNumber(String number) {
    return 'Order #$number';
  }

  @override
  String get orderProcessing => 'Processing';

  @override
  String get orderShipped => 'Shipped';

  @override
  String get orderDelivered => 'Delivered';

  @override
  String get noOrders => 'No orders yet';

  @override
  String get done => 'Done';
}
