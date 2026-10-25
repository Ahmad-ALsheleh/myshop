import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';

/// An icon painted with the brand gradient (active tab, outlined hearts,
/// section icons of checkout and profile).
class GradientIcon extends StatelessWidget {
  const GradientIcon(this.icon, {super.key, this.size = 24});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final gradient = context.palette.iconGradient;
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: gradient.createShader,
      // The mask only keeps the shape, so any opaque color works here.
      child: Icon(icon, size: size, color: context.palette.onAccent),
    );
  }
}
