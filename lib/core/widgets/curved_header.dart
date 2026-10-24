import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extensions/context_extensions.dart';

/// Gradient header whose bottom-end corner is a large elliptical curve
/// (sign in screens, profile). [height] is measured under the status bar.
class CurvedHeader extends StatelessWidget {
  const CurvedHeader({
    super.key,
    required this.height,
    required this.curve,
    required this.child,
  });

  final double height;

  /// Radii of the bottom-end curve.
  final Radius curve;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        width: double.infinity,
        height: topInset + height,
        padding: EdgeInsets.only(top: topInset),
        decoration: BoxDecoration(
          gradient: context.palette.brandGradient,
          borderRadius: BorderRadiusDirectional.only(bottomEnd: curve),
        ),
        child: child,
      ),
    );
  }
}
