import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/features/cart/presentation/widgets/cart_pill.dart';
import 'package:myshop/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:myshop/features/product/data/mock/mock_products.dart';
import 'package:myshop/features/product/data/models/product_size.dart';
import 'package:myshop/features/product/presentation/widgets/product_card.dart';
import 'package:myshop/features/product/presentation/widgets/size_selector.dart';
import 'package:myshop/features/shell/presentation/widgets/app_bottom_navigation.dart';

import '../helpers/pump_app.dart';

void main() {
  group('ProductCard', () {
    testWidgets('a sale product shows the badge and both prices', (
      tester,
    ) async {
      await tester.pumpApp(
        const SizedBox(
          width: 163,
          child: ProductCard(product: saodimallsuTurtleneck),
        ),
      );

      expect(find.text('-50%'), findsOneWidget);
      expect(find.text(r'$49'), findsOneWidget);
      expect(find.text(r'$99'), findsOneWidget);
    });

    testWidgets('a regular product has no badge', (tester) async {
      await tester.pumpApp(
        const SizedBox(width: 163, child: ProductCard(product: jouicaSweater)),
      );

      expect(find.textContaining('%'), findsNothing);
      expect(find.text(r'$78.54'), findsOneWidget);
    });

    testWidgets('the heart toggles the favorite', (tester) async {
      final container = await tester.pumpApp(
        const SizedBox(width: 163, child: ProductCard(product: jouicaSweater)),
      );
      bool isFavorite() => container.read(isFavoriteProvider(jouicaSweater.id));

      expect(isFavorite(), isFalse);
      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pump();
      expect(isFavorite(), isTrue);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('fits the height given by heightFor', (tester) async {
      await tester.pumpApp(
        const Align(
          alignment: AlignmentDirectional.topStart,
          child: SizedBox(
            width: 163,
            child: ProductCard(product: saodimallsuTurtleneck),
          ),
        ),
      );

      // A grid row of heightFor never clips the card, and wastes < 1pt.
      final height = tester.getSize(find.byType(ProductCard)).height;
      final expected = ProductCard.heightFor(163, TextScaler.noScaling);
      expect(height, lessThanOrEqualTo(expected));
      expect(expected - height, lessThan(1));
    });
  });

  testWidgets('SizeSelector reports the tapped size', (tester) async {
    ProductSize? tapped;
    await tester.pumpApp(
      SizeSelector(
        sizes: ProductSize.values,
        selected: const {ProductSize.s},
        onTap: (size) => tapped = size,
      ),
    );

    await tester.tap(find.text('XL'));
    expect(tapped, ProductSize.xl);
  });

  group('CartPill', () {
    testWidgets('shows the cart total and count', (tester) async {
      await tester.pumpApp(CartPill(onTap: () {}));

      expect(find.text(r'$239.98'), findsOneWidget);
      expect(find.text('2 items'), findsOneWidget);
    });

    testWidgets('uses Arabic plural forms', (tester) async {
      await tester.pumpApp(CartPill(onTap: () {}), locale: const Locale('ar'));

      expect(find.text('منتجان'), findsOneWidget);
    });
  });

  testWidgets('AppBottomNavigation reports the tapped tab', (tester) async {
    int? selected;
    var cartTaps = 0;
    await tester.pumpApp(
      Align(
        alignment: Alignment.bottomCenter,
        child: AppBottomNavigation(
          currentIndex: 0,
          onTabSelected: (index) => selected = index,
          onCartTap: () => cartTaps++,
        ),
      ),
    );

    await tester.tap(find.text('Favorite'));
    await tester.tap(find.byType(CartPill));
    expect(selected, 2);
    expect(cartTaps, 1);
  });
}
