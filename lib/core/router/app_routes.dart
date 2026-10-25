/// Every route path of the app in one place.
///
/// New screens add their path here as they are built.
abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const phone = '/phone';
  static const verification = '/verification';
  static const verificationPhoneParam = 'phone';

  // Tabs of the bottom navigation.
  static const home = '/home';
  static const catalogue = '/catalogue';
  static const favorites = '/favorites';
  static const profile = '/profile';

  /// Items of a category, inside the catalogue tab.
  static const categoryItems = ':categoryId';
  static const categoryIdParam = 'categoryId';

  static const search = '/search';
  static const product = '/product/:productId';
  static const productIdParam = 'productId';
  static const filter = '/filter/:categoryId';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const orders = '/orders';
  static const settings = '/settings';
  static const addresses = '/addresses';
  static const addressForm = '/addresses/form';
  static const addressIdParam = 'id';
  static const paymentMethods = '/payment-methods';
  static const cardForm = '/payment-methods/new';

  /// New address when [addressId] is `null`.
  static String addressFormOf(String? addressId) => Uri(
    path: addressForm,
    queryParameters: addressId == null ? null : {addressIdParam: addressId},
  ).toString();

  static String verificationOf(String phone) => Uri(
    path: verification,
    queryParameters: {verificationPhoneParam: phone},
  ).toString();

  static String categoryItemsOf(String categoryId) => '$catalogue/$categoryId';

  static String productOf(String productId) => '/product/$productId';

  static String filterOf(String categoryId) => '/filter/$categoryId';

  static const _signIn = {phone, verification};

  /// Where to go for the current app state, or `null` to stay.
  static String? redirect(
    String location, {
    required bool onboardingSeen,
    required bool canEnterApp,
  }) {
    if (!onboardingSeen) return location == onboarding ? null : onboarding;
    if (!canEnterApp) return _signIn.contains(location) ? null : phone;
    if (location == '/' ||
        location == onboarding ||
        _signIn.contains(location)) {
      return home;
    }
    return null;
  }
}
