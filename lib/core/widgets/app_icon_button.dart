import 'package:flutter/material.dart';

/// Tappable icon that takes exactly the icon size.
///
/// Material 3 `IconButton` keeps a 40pt minimum size and centres the icon
/// in it, which moves icons away from their place in the design.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    required this.size,
    required this.color,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        enabled: onPressed != null,
        child: InkResponse(
          onTap: onPressed,
          radius: size,
          child: Icon(icon, size: size, color: color),
        ),
      ),
    );
  }
}
