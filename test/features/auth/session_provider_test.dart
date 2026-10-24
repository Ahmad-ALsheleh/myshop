import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/core/storage/preferences_provider.dart';
import 'package:myshop/features/auth/data/repositories/auth_repository.dart';
import 'package:myshop/features/auth/presentation/providers/session_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences preferences;

  ProviderContainer createContainer() => ProviderContainer.test(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(preferences),
      authRepositoryProvider.overrideWithValue(
        AuthRepository(latency: Duration.zero),
      ),
    ],
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    preferences = await SharedPreferences.getInstance();
  });

  test('signed out by default', () {
    expect(createContainer().read(sessionProvider), isNull);
  });

  test('signing in keeps the user across restarts', () async {
    await createContainer()
        .read(sessionProvider.notifier)
        .signIn(phone: '+380991234567', code: '6666');

    final restarted = createContainer().read(sessionProvider);
    expect(restarted?.phone, '+380991234567');
    expect(restarted?.name, 'Oleh Chabanov');
  });

  test('a code that is not 4 digits is rejected', () async {
    final container = createContainer();

    await expectLater(
      container
          .read(sessionProvider.notifier)
          .signIn(phone: '+380991234567', code: '12a'),
      throwsA(isA<InvalidCodeException>()),
    );
    expect(container.read(sessionProvider), isNull);
  });

  test('signing out forgets the user', () async {
    final notifier = createContainer().read(sessionProvider.notifier);
    await notifier.signIn(phone: '+380991234567', code: '1234');
    await notifier.signOut();

    expect(createContainer().read(sessionProvider), isNull);
  });
}
