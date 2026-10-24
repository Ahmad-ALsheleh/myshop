import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myshop/core/widgets/app_text_field.dart';
import 'package:myshop/core/widgets/primary_button.dart';
import 'package:myshop/core/widgets/quantity_stepper.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../helpers/pump_app.dart';

void main() {
  group('QuantityStepper', () {
    testWidgets('shows the value and calls + and −', (tester) async {
      var plus = 0;
      var minus = 0;
      await tester.pumpApp(
        QuantityStepper(
          value: 3,
          onIncrement: () => plus++,
          onDecrement: () => minus++,
        ),
      );

      expect(find.text('3'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add_circle_outline));
      await tester.tap(find.byIcon(Icons.remove_circle_outline));
      expect((plus, minus), (1, 1));
    });
  });

  group('PrimaryButton', () {
    testWidgets('ignores taps while loading', (tester) async {
      var taps = 0;
      await tester.pumpApp(
        PrimaryButton(label: 'Pay', onPressed: () => taps++, isLoading: true),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(PrimaryButton));
      expect(taps, 0);
    });
  });

  group('AppTextField', () {
    Widget form(FormGroup group) => ReactiveForm(
      formGroup: group,
      child: const AppTextField<String>(formControlName: 'name'),
    );

    testWidgets('shows the app-wide error text once touched', (tester) async {
      final group = FormGroup({
        'name': FormControl<String>(validators: [Validators.required]),
      });
      await tester.pumpApp(form(group));
      expect(find.text('This field is required'), findsNothing);

      group.markAllAsTouched();
      await tester.pump();
      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('error texts are translated', (tester) async {
      final group = FormGroup({
        'name': FormControl<String>(
          value: 'ab',
          validators: [Validators.minLength(3)],
        ),
      })..markAllAsTouched();
      await tester.pumpApp(form(group), locale: const Locale('ar'));

      expect(find.text('أدخل 3 أحرف على الأقل'), findsOneWidget);
    });
  });
}
