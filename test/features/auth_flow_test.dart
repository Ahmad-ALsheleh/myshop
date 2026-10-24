import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/app.dart';
import 'package:myshop/core/storage/preferences_provider.dart';
import 'package:myshop/features/auth/data/repositories/auth_repository.dart';
import 'package:myshop/features/auth/presentation/providers/session_provider.dart';
import 'package:myshop/features/auth/presentation/screens/phone_screen.dart';
import 'package:myshop/features/auth/presentation/screens/verification_screen.dart';
import 'package:myshop/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Future<ProviderContainer> startApp(
    WidgetTester tester, [
    Map<String, Object> prefs = const {},
  ]) async {
    SharedPreferences.setMockInitialValues({'locale': 'en', ...prefs});
    final container = ProviderContainer.test(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
        authRepositoryProvider.overrideWithValue(
          AuthRepository(latency: Duration.zero),
        ),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const MyShopApp()),
    );
    await tester.pump();
    return container;
  }

  // The next screens have endless animations: pump a few frames instead of
  // pumpAndSettle.
  Future<void> frames(WidgetTester tester) async {
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 300));
    }
  }

  testWidgets('first launch: onboarding → phone → code → app', (tester) async {
    final container = await startApp(tester);
    expect(find.byType(OnboardingScreen), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await frames(tester);
    expect(find.byType(PhoneScreen), findsOneWidget);

    // An incomplete number is refused.
    await tester.enterText(find.byType(TextField), '9912');
    await tester.tap(find.text('Send Verification Code'));
    await frames(tester);
    expect(find.text('Enter a valid phone number'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '991234567');
    expect(find.text('(99) 123 45 67'), findsOneWidget);
    await tester.tap(find.text('Send Verification Code'));
    await frames(tester);
    expect(find.byType(VerificationScreen), findsOneWidget);
    expect(find.text('+380991234567'), findsOneWidget);

    // Typing the 4th digit verifies the code by itself.
    await tester.enterText(find.byType(TextField), '6666');
    await frames(tester);
    expect(find.byType(VerificationScreen), findsNothing);
    expect(container.read(sessionProvider)?.phone, '+380991234567');
  });

  testWidgets('Skip opens the app as a guest', (tester) async {
    final container = await startApp(tester, {'onboarding_seen': true});
    expect(find.byType(PhoneScreen), findsOneWidget);

    await tester.tap(find.text('Skip'));
    await frames(tester);
    expect(find.byType(PhoneScreen), findsNothing);
    expect(container.read(guestModeProvider), isTrue);
  });
}
