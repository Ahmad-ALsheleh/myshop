import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'preferences_provider.dart';

/// A yes/no setting saved in shared preferences under [key].
///
/// ```dart
/// final onboardingSeenProvider = NotifierProvider<PersistedFlag, bool>(
///   () => PersistedFlag('onboarding_seen'),
/// );
/// ```
class PersistedFlag extends Notifier<bool> {
  PersistedFlag(this.key);

  final String key;

  @override
  bool build() => ref.read(sharedPreferencesProvider).getBool(key) ?? false;

  Future<void> set(bool value) async {
    state = value;
    await ref.read(sharedPreferencesProvider).setBool(key, value);
  }
}
