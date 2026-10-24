/// Every route path of the app in one place.
///
/// New screens add their path here as they are built.
abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const phone = '/phone';
  static const verification = '/verification';
  static const verificationPhoneParam = 'phone';

  /// Main app. Temporary widget gallery until the home screen exists.
  static const home = '/';

  static String verificationOf(String phone) => Uri(
    path: verification,
    queryParameters: {verificationPhoneParam: phone},
  ).toString();

  static const _signIn = {phone, verification};

  /// Where to go for the current app state, or `null` to stay.
  static String? redirect(
    String location, {
    required bool onboardingSeen,
    required bool canEnterApp,
  }) {
    if (!onboardingSeen) return location == onboarding ? null : onboarding;
    if (!canEnterApp) return _signIn.contains(location) ? null : phone;
    if (location == onboarding || _signIn.contains(location)) return home;
    return null;
  }
}
