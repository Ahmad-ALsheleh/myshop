import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/features/cart/data/models/cart_item.dart';
import 'package:myshop/features/cart/presentation/providers/cart_provider.dart';
import 'package:myshop/features/product/data/mock/mock_products.dart';
import 'package:myshop/features/product/data/models/product_color.dart';
import 'package:myshop/features/product/data/models/product_size.dart';

void main() {
  late ProviderContainer container;
  late CartNotifier cart;

  List<CartItem> items() => container.read(cartProvider);

  setUp(() {
    container = ProviderContainer.test();
    cart = container.read(cartProvider.notifier);
  });

  test('starts with the cart of the design: \$239.98, 2 items', () {
    expect(items().totalPrice, 23998);
    expect(items().totalQuantity, 2);
  });

  test('adding the same product with the same options raises quantity', () {
    cart.add(astylishCardigan, color: ProductColor.brown, size: ProductSize.s);

    expect(items(), hasLength(2));
    expect(items().first.quantity, 2);
    expect(items().totalPrice, 23998 + 8999);
  });

  test('a different size or color is a separate line', () {
    cart
      ..add(astylishCardigan, color: ProductColor.brown, size: ProductSize.m)
      ..add(astylishCardigan, color: ProductColor.gray, size: ProductSize.s);

    expect(items(), hasLength(4));
  });

  test('increment and decrement change one line only', () {
    final first = items().first;
    cart.increment(first);
    cart.increment(first);
    cart.decrement(first);

    expect(items().first.quantity, 2);
    expect(items().last.quantity, 1);
  });

  test('decrement never goes below 1', () {
    cart.decrement(items().first);

    expect(items().first.quantity, 1);
  });

  test('remove and clear', () {
    cart.remove(items().first);
    expect(items().single.product, boriflorsDress);

    cart.clear();
    expect(items(), isEmpty);
    expect(items().totalPrice, 0);
  });

  test('a line shows the photo of the chosen color', () {
    const item = CartItem(product: astylishCardigan, color: ProductColor.gray);

    expect(item.image, endsWith('astylish_cardigan_gray.jpg'));
  });
}
