import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/persisted_flag.dart';

/// "Get Started" was tapped once: the onboarding is not shown again.
final onboardingSeenProvider = NotifierProvider<PersistedFlag, bool>(
  () => PersistedFlag('onboarding_seen'),
);
