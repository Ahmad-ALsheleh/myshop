import 'package:flutter/widgets.dart';

/// Text that comes with the data (product names, descriptions, category
/// names...) in both supported languages, the way a real API would return it.
///
/// Fixed UI strings do NOT use this: they live in the ARB files.
@immutable
class LocalizedText {
  const LocalizedText({required this.en, required this.ar});

  final String en;
  final String ar;

  String resolve(Locale locale) => locale.languageCode == 'ar' ? ar : en;

  /// Case-insensitive match in either language (used by search).
  bool matches(String query) {
    final normalized = query.trim().toLowerCase();
    return en.toLowerCase().contains(normalized) || ar.contains(normalized);
  }
}
