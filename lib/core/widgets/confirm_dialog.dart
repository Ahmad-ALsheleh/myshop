import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';

/// "Are you sure?" dialog. Returns `true` when [confirmLabel] is tapped.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String message,
  required String confirmLabel,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(context.l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
