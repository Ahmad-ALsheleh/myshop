import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Semantic colors of the app, exposed as a [ThemeExtension].
///
/// Access it with `context.palette` (see `context_extensions.dart`).
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textBody,
    required this.textSecondary,
    required this.hint,
    required this.border,
    required this.accent,
    required this.onAccent,
    required this.sale,
    required this.rating,
    required this.success,
    required this.shadow,
    required this.brandGradient,
    required this.saleBadgeGradient,
  });

  final Color background;
  final Color surface;
  final Color textPrimary;

  /// Descriptions, reviews, input text, chips, stepper count.
  final Color textBody;
  final Color textSecondary;

  /// Placeholder of the phone input, e.g. "(99) 999 99 99".
  /// The search field placeholder uses [textSecondary] instead.
  final Color hint;
  final Color border;
  final Color accent;
  final Color onAccent;
  final Color sale;
  final Color rating;
  final Color success;
  final Color shadow;

  /// Purple gradient used by headers, the cart pill and the success popup.
  final LinearGradient brandGradient;

  /// Red-to-orange gradient of the "-50%" badge.
  final LinearGradient saleBadgeGradient;

  static const _brandGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [AppColors.brandDark, AppColors.brandLight],
  );

  // Directional: the badge sits on the start edge, red side first.
  static const _saleBadgeGradient = LinearGradient(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
    colors: [AppColors.saleBadgeStart, AppColors.saleBadgeEnd],
  );

  static const light = AppPalette(
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    textPrimary: AppColors.lightTextPrimary,
    textBody: AppColors.lightTextBody,
    textSecondary: AppColors.textSecondary,
    hint: AppColors.lightHint,
    border: AppColors.lightBorder,
    accent: AppColors.accent,
    onAccent: AppColors.white,
    sale: AppColors.sale,
    rating: AppColors.rating,
    success: AppColors.success,
    shadow: Color(0x0F000000),
    brandGradient: _brandGradient,
    saleBadgeGradient: _saleBadgeGradient,
  );

  static const dark = AppPalette(
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    textPrimary: AppColors.darkTextPrimary,
    textBody: AppColors.darkTextBody,
    textSecondary: AppColors.textSecondary,
    hint: AppColors.darkHint,
    border: AppColors.darkBorder,
    accent: AppColors.accent,
    onAccent: AppColors.white,
    sale: AppColors.sale,
    rating: AppColors.rating,
    success: AppColors.success,
    shadow: Color(0x40000000),
    brandGradient: _brandGradient,
    saleBadgeGradient: _saleBadgeGradient,
  );

  @override
  AppPalette copyWith({
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textBody,
    Color? textSecondary,
    Color? hint,
    Color? border,
    Color? accent,
    Color? onAccent,
    Color? sale,
    Color? rating,
    Color? success,
    Color? shadow,
    LinearGradient? brandGradient,
    LinearGradient? saleBadgeGradient,
  }) {
    return AppPalette(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textBody: textBody ?? this.textBody,
      textSecondary: textSecondary ?? this.textSecondary,
      hint: hint ?? this.hint,
      border: border ?? this.border,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      sale: sale ?? this.sale,
      rating: rating ?? this.rating,
      success: success ?? this.success,
      shadow: shadow ?? this.shadow,
      brandGradient: brandGradient ?? this.brandGradient,
      saleBadgeGradient: saleBadgeGradient ?? this.saleBadgeGradient,
    );
  }

  @override
  AppPalette lerp(covariant AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textBody: Color.lerp(textBody, other.textBody, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      hint: Color.lerp(hint, other.hint, t)!,
      border: Color.lerp(border, other.border, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      sale: Color.lerp(sale, other.sale, t)!,
      rating: Color.lerp(rating, other.rating, t)!,
      success: Color.lerp(success, other.success, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      brandGradient: LinearGradient.lerp(
        brandGradient,
        other.brandGradient,
        t,
      )!,
      saleBadgeGradient: LinearGradient.lerp(
        saleBadgeGradient,
        other.saleBadgeGradient,
        t,
      )!,
    );
  }
}
