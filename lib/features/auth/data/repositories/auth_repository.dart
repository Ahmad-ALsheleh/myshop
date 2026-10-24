import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mock/mock_user.dart';
import '../models/user.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(),
);

/// Thrown by [AuthRepository.verifyCode] when the code is rejected.
class InvalidCodeException implements Exception {
  const InvalidCodeException();
}

/// Phone number + one-time code sign in, faked locally.
class AuthRepository {
  /// [latency] fakes the network so buttons can show their loading state.
  /// Tests pass [Duration.zero].
  AuthRepository({this.latency = const Duration(milliseconds: 800)});

  static const codeLength = 4;

  final Duration latency;

  Future<void> sendCode(String phone) => Future<void>.delayed(latency);

  /// Accepts any [codeLength]-digit code: there is no real SMS.
  Future<User> verifyCode({required String phone, required String code}) async {
    await Future<void>.delayed(latency);
    if (!RegExp('^\\d{$codeLength}\$').hasMatch(code)) {
      throw const InvalidCodeException();
    }
    return userFor(phone);
  }

  /// The mock account, with the phone number the user signed in with.
  User userFor(String phone) => mockUser.copyWith(phone: phone);
}
