import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/country.dart';
import '../../data/repositories/auth_repository.dart';
import 'session_provider.dart';

final countriesProvider = Provider<List<Country>>(
  (ref) => ref.watch(authRepositoryProvider).getCountries(),
);

/// Country chosen on the phone screen.
final selectedCountryProvider =
    NotifierProvider.autoDispose<SelectedCountryNotifier, Country>(
      SelectedCountryNotifier.new,
    );

class SelectedCountryNotifier extends Notifier<Country> {
  @override
  Country build() => ref.watch(countriesProvider).first;

  void select(Country country) => state = country;
}

/// "Send Verification Code" / "Resend Code": loading and error state.
final sendCodeProvider =
    AsyncNotifierProvider.autoDispose<SendCodeNotifier, void>(
      SendCodeNotifier.new,
    );

class SendCodeNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  /// Returns whether the code was sent.
  Future<bool> send(String phone) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).sendCode(phone),
    );
    if (!ref.mounted) return false;
    state = result;
    return !result.hasError;
  }
}

/// Checking the code typed on the verification screen.
final verifyCodeProvider =
    AsyncNotifierProvider.autoDispose<VerifyCodeNotifier, void>(
      VerifyCodeNotifier.new,
    );

class VerifyCodeNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  /// Signs in on success; the router then opens the app by itself.
  /// The error is an [InvalidCodeException] when the code is rejected.
  Future<void> verify({required String phone, required String code}) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(sessionProvider.notifier).signIn(phone: phone, code: code),
    );
    if (ref.mounted) state = result;
  }
}
