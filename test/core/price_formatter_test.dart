import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/core/utils/price_formatter.dart';

void main() {
  test('whole amounts have no decimals, others have two', () {
    expect(formatPrice(4900), r'$49');
    expect(formatPrice(8999), r'$89.99');
    expect(formatPrice(23998), r'$239.98');
    expect(formatPrice(500000), r'$5000');
    expect(formatPrice(1805), r'$18.05');
  });
}
