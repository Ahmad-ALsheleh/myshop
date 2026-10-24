import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_dimens.dart';
import '../theme/app_shadows.dart';
import '../theme/app_text_styles.dart';

/// White pill search field ("What are you looking for?").
///
/// Backed by a reactive_forms control like every other input of the app.
/// With [onTap] set it becomes a read-only button (e.g. home → search).
class AppSearchField extends StatefulWidget {
  const AppSearchField({
    super.key,
    this.onChanged,
    this.onTap,
    this.initialValue,
    this.autofocus = false,
  });

  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final String? initialValue;
  final bool autofocus;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late final FormControl<String> _control = FormControl<String>(
    value: widget.initialValue,
  );

  @override
  void initState() {
    super.initState();
    _control.valueChanges.listen(
      (value) => widget.onChanged?.call(value ?? ''),
    );
  }

  @override
  void dispose() {
    _control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final textStyle = AppTextStyles.bodySmall.copyWith(color: palette.textBody);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        boxShadow: AppShadows.soft(palette),
      ),
      child: ReactiveTextField<String>(
        formControl: _control,
        readOnly: widget.onTap != null,
        onTap: widget.onTap == null ? null : (_) => widget.onTap!(),
        autofocus: widget.autofocus,
        textInputAction: TextInputAction.search,
        style: textStyle,
        // Fill the 44pt pill so the text sits in its vertical centre.
        expands: true,
        maxLines: null,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: context.l10n.searchHint,
          hintStyle: textStyle.copyWith(color: palette.textSecondary),
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          isCollapsed: true,
          contentPadding: EdgeInsetsDirectional.zero,
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: AppSpacing.searchIconStart,
              end: AppSpacing.searchIconEnd,
            ),
            child: Icon(
              Icons.search,
              size: AppSizes.searchIcon,
              color: palette.textSecondary,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(),
        ),
      ),
    );
  }
}
