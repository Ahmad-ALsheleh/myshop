import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/country.dart';

/// Bottom sheet listing the countries; returns the chosen one.
Future<Country?> showCountryPicker(
  BuildContext context, {
  required List<Country> countries,
  required Country selected,
}) {
  return showModalBottomSheet<Country>(
    context: context,
    showDragHandle: true,
    builder: (context) =>
        _CountryPickerSheet(countries: countries, selected: selected),
  );
}

class _CountryPickerSheet extends StatelessWidget {
  const _CountryPickerSheet({required this.countries, required this.selected});

  final List<Country> countries;
  final Country selected;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.m,
            ),
            child: Text(
              context.l10n.selectCountry,
              style: AppTextStyles.headline.copyWith(
                color: palette.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          for (final country in countries)
            ListTile(
              onTap: () => Navigator.pop(context, country),
              leading: Text(
                country.flag,
                style: AppTextStyles.headline,
                textDirection: TextDirection.ltr,
              ),
              title: Text(
                context.localize(country.name),
                style: AppTextStyles.body.copyWith(color: palette.textPrimary),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.xs,
                children: [
                  Text(
                    country.dialCode,
                    textDirection: TextDirection.ltr,
                    style: AppTextStyles.body.copyWith(
                      color: palette.textSecondary,
                    ),
                  ),
                  if (country.isoCode == selected.isoCode)
                    Icon(Icons.check, color: palette.accent),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
