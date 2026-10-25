import '../../../../core/l10n/localized_text.dart';
import '../../../../core/utils/digit_mask.dart';
import '../models/country.dart';

/// Ukraine first: it is the country of the design.
const mockCountries = <Country>[
  Country(
    isoCode: 'UA',
    name: LocalizedText(en: 'Ukraine', ar: 'أوكرانيا'),
    dialCode: '+380',
    flag: '🇺🇦',
    mask: DigitMask('(##) ### ## ##'),
  ),
  Country(
    isoCode: 'JO',
    name: LocalizedText(en: 'Jordan', ar: 'الأردن'),
    dialCode: '+962',
    flag: '🇯🇴',
    mask: DigitMask('# #### ####'),
  ),
  Country(
    isoCode: 'SA',
    name: LocalizedText(en: 'Saudi Arabia', ar: 'السعودية'),
    dialCode: '+966',
    flag: '🇸🇦',
    mask: DigitMask('## ### ####'),
  ),
  Country(
    isoCode: 'AE',
    name: LocalizedText(en: 'United Arab Emirates', ar: 'الإمارات'),
    dialCode: '+971',
    flag: '🇦🇪',
    mask: DigitMask('## ### ####'),
  ),
  Country(
    isoCode: 'SY',
    name: LocalizedText(en: 'Syria', ar: 'سوريا'),
    dialCode: '+963',
    flag: '🇸🇾',
    mask: DigitMask('### ### ###'),
  ),
  Country(
    isoCode: 'US',
    name: LocalizedText(en: 'United States', ar: 'الولايات المتحدة'),
    dialCode: '+1',
    flag: '🇺🇸',
    mask: DigitMask('(###) ###-####'),
  ),
];
