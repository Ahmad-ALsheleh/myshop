import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/preferences_provider.dart';
import '../../data/models/user.dart';
import '../../data/repositories/auth_repository.dart';

/// The signed-in user, or `null`. Survives app restarts (the phone number is
/// saved in shared preferences).
final sessionProvider = NotifierProvider<SessionNotifier, User?>(
  SessionNotifier.new,
);

class SessionNotifier extends Notifier<User?> {
  static const _phoneKey = 'session_phone';

  @override
  User? build() {
    final phone = ref.read(sharedPreferencesProvider).getString(_phoneKey);
    return phone == null
        ? null
        : ref.watch(authRepositoryProvider).userFor(phone);
  }

  /// Verifies the code and signs in.
  /// Throws [InvalidCodeException] when the code is rejected.
  Future<void> signIn({required String phone, required String code}) async {
    final user = await ref
        .read(authRepositoryProvider)
        .verifyCode(phone: phone, code: code);
    if (!ref.mounted) return;
    state = user;
    await ref.read(sharedPreferencesProvider).setString(_phoneKey, phone);
  }

  Future<void> signOut() async {
    state = null;
    await ref.read(sharedPreferencesProvider).remove(_phoneKey);
  }
}
