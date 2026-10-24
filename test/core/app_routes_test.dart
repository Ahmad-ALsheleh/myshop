import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/core/router/app_routes.dart';

void main() {
  String? redirect(String location, {bool seen = true, bool inApp = true}) =>
      AppRoutes.redirect(location, onboardingSeen: seen, canEnterApp: inApp);

  test('the onboarding comes first', () {
    expect(redirect(AppRoutes.home, seen: false, inApp: false), '/onboarding');
    expect(redirect(AppRoutes.onboarding, seen: false), isNull);
  });

  test('signed out users stay on the sign in screens', () {
    expect(redirect(AppRoutes.home, inApp: false), AppRoutes.phone);
    expect(redirect(AppRoutes.phone, inApp: false), isNull);
    // The router passes the path only (no query string).
    expect(redirect(AppRoutes.verification, inApp: false), isNull);
  });

  test('signed in users (or guests) skip onboarding and sign in', () {
    expect(redirect(AppRoutes.onboarding), AppRoutes.home);
    expect(redirect(AppRoutes.phone), AppRoutes.home);
    expect(redirect(AppRoutes.home), isNull);
  });
}
