import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import 'primary_button.dart';

/// Bottom sheet to pick one of [options]. Returns the chosen value.
Future<T?> showOptionsSheet<T>(
  BuildContext context, {
  String? title,
  required List<T> options,
  required T? selected,
  required String Function(T option) labelOf,
}) {
  return showModalBottomSheet<T>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) => _SheetFrame(
      title: title,
      children: [
        for (final option in options)
          _OptionTile(
            label: labelOf(option),
            isSelected: option == selected,
            onTap: () => Navigator.pop(context, option),
          ),
      ],
    ),
  );
}

/// Bottom sheet to pick several [options]; returns the new selection when
/// the user confirms, `null` when the sheet is dismissed.
Future<Set<T>?> showMultiOptionsSheet<T>(
  BuildContext context, {
  String? title,
  required List<T> options,
  required Set<T> selected,
  required String Function(T option) labelOf,
  required String confirmLabel,
}) {
  return showModalBottomSheet<Set<T>>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      final chosen = {...selected};
      return StatefulBuilder(
        builder: (context, setState) => _SheetFrame(
          title: title,
          footer: PrimaryButton(
            label: confirmLabel,
            onPressed: () => Navigator.pop(context, chosen),
          ),
          children: [
            for (final option in options)
              _OptionTile(
                label: labelOf(option),
                isSelected: chosen.contains(option),
                onTap: () => setState(
                  () => chosen.contains(option)
                      ? chosen.remove(option)
                      : chosen.add(option),
                ),
              ),
          ],
        ),
      );
    },
  );
}

class _SheetFrame extends StatelessWidget {
  const _SheetFrame({required this.title, required this.children, this.footer});

  final String? title;
  final List<Widget> children;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.75,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.m,
                ),
                child: Text(
                  title!,
                  style: AppTextStyles.headline.copyWith(
                    color: palette.textPrimary,
                  ),
                ),
              ),
            Flexible(child: ListView(shrinkWrap: true, children: children)),
            if (footer != null)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.m),
                child: footer,
              ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return ListTile(
      onTap: onTap,
      title: Text(
        label,
        style: AppTextStyles.body.copyWith(
          color: palette.textPrimary,
          fontWeight: isSelected ? FontWeight.w700 : null,
        ),
      ),
      trailing: isSelected ? Icon(Icons.check, color: palette.accent) : null,
    );
  }
}
