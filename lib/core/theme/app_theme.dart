import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_fonts.dart';
import 'app_palette.dart';
import 'app_text_styles.dart';

/// Builds [ThemeData] for light and dark modes from the design tokens.
abstract final class AppTheme {
  static ThemeData light({String fontFamily = AppFonts.latin}) =>
      _build(AppPalette.light, Brightness.light, fontFamily);

  static ThemeData dark({String fontFamily = AppFonts.latin}) =>
      _build(AppPalette.dark, Brightness.dark, fontFamily);

  static ThemeData of(Brightness brightness, {required String fontFamily}) =>
      brightness == Brightness.dark
      ? dark(fontFamily: fontFamily)
      : light(fontFamily: fontFamily);

  static ThemeData _build(
    AppPalette palette,
    Brightness brightness,
    String fontFamily,
  ) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.brandLight,
      onPrimary: AppColors.white,
      secondary: palette.accent,
      onSecondary: palette.onAccent,
      error: palette.sale,
      onError: AppColors.white,
      surface: palette.surface,
      onSurface: palette.textPrimary,
    );

    final textTheme =
        const TextTheme(
          displaySmall: AppTextStyles.display,
          headlineSmall: AppTextStyles.headline,
          titleLarge: AppTextStyles.headline,
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.body,
          bodySmall: AppTextStyles.bodySmall,
          labelSmall: AppTextStyles.caption,
          labelLarge: AppTextStyles.button,
          labelMedium: AppTextStyles.label,
        ).apply(
          fontFamily: fontFamily,
          bodyColor: palette.textPrimary,
          displayColor: palette.textPrimary,
        );

    final radiusS = BorderRadius.circular(AppRadius.s);
    OutlineInputBorder inputBorder(Color color) => OutlineInputBorder(
      borderRadius: radiusS,
      borderSide: BorderSide(color: color),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      fontFamily: fontFamily,
      textTheme: textTheme,
      scaffoldBackgroundColor: palette.background,
      extensions: [palette],
      dividerTheme: DividerThemeData(
        color: palette.border,
        thickness: 1,
        space: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        toolbarHeight: AppSizes.toolbarHeight,
        titleTextStyle: AppTextStyles.headline.copyWith(
          fontFamily: fontFamily,
          color: AppColors.white,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: palette.accent,
          foregroundColor: palette.onAccent,
          elevation: 0,
          minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
          shape: RoundedRectangleBorder(borderRadius: radiusS),
          textStyle: AppTextStyles.button.copyWith(fontFamily: fontFamily),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: palette.textSecondary,
          textStyle: AppTextStyles.button.copyWith(fontFamily: fontFamily),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.surface,
        hintStyle: AppTextStyles.body.copyWith(color: palette.textSecondary),
        errorStyle: AppTextStyles.caption.copyWith(color: palette.sale),
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.m,
          vertical: AppSpacing.inputVertical,
        ),
        border: inputBorder(palette.border),
        enabledBorder: inputBorder(palette.border),
        focusedBorder: inputBorder(palette.accent),
        errorBorder: inputBorder(palette.sale),
        focusedErrorBorder: inputBorder(palette.sale),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: palette.surface,
        modalBackgroundColor: palette.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.sheet),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: palette.accent),
    );
  }
}
