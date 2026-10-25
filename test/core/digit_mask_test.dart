import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/core/utils/digit_mask.dart';

void main() {
  const mask = DigitMask('(##) ### ## ##');

  test('lays digits on the mask as they are typed', () {
    expect(mask.apply('9'), '(9');
    expect(mask.apply('991'), '(99) 1');
    expect(mask.apply('991234567'), '(99) 123 45 67');
  });

  test('ignores non digits and extra digits', () {
    expect(mask.apply('99-12a3 45 67 8 9'), '(99) 123 45 67');
  });

  test('a number is complete with all the digits', () {
    expect(mask.length, 9);
    expect(mask.isComplete('(99) 123 45 6'), isFalse);
    expect(mask.isComplete('(99) 123 45 67'), isTrue);
    expect(mask.isComplete(null), isFalse);
  });

  test('the formatter keeps the cursor at the end', () {
    final value = mask.formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: '9912'),
    );
    expect(value.text, '(99) 12');
    expect(value.selection.baseOffset, value.text.length);
  });
}
