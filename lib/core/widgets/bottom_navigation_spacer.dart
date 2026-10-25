import 'package:flutter/widgets.dart';

import '../theme/app_dimens.dart';

/// Space at the end of a tab's scroll view, so the last items can scroll
/// above the bottom navigation.
///
/// Inside the tabs the shell uses `Scaffold.extendBody`, which already adds
/// the navigation height to `MediaQuery.padding.bottom`.
class BottomNavigationSpacer extends StatelessWidget {
  const BottomNavigationSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.paddingOf(context).bottom + AppSpacing.m,
    );
  }
}
