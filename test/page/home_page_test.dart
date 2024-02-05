import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:name_your_price/page/home_page.dart';

void main() {
  group("Home page test", () {
    Finder checkBtn() => find.text("Check");
    Finder nextBtn() => find.text("Next");
    Finder priceInput() => find.byKey(const Key('priceInput'));

    testWidgets(
      'Click next to iterate over the product list',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: HomePage(),
        ));

        expect(find.text(products[0].name), findsOneWidget);

        for (var i = 1; i < 7; i++) {
          await tester.tap(checkBtn());
          await tester.enterText(priceInput(), '0');
          await tester.pump();
          await tester.tap(nextBtn());
          await tester.pump();
          expect(find.text(products[i].name), findsOneWidget);
        }

        await tester.tap(checkBtn());
        await tester.pump();
        await tester.tap(nextBtn());
        await tester.pump();
        expect(find.text(products[6].name), findsOneWidget);
      },
    );

    testWidgets("Check result and show next product",
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: HomePage(),
      ));

      expect(nextBtn(), findsNothing);
      expect(find.byKey(const Key(('result'))), findsNothing);
      await tester.enterText(priceInput(), '11000000');
      await tester.tap(checkBtn());
      await tester.pump();
      expect(nextBtn(), findsOneWidget);
      expect(find.byKey(const Key(('result'))), findsOneWidget);
      expect(find.text('pass'), findsOneWidget);

      await tester.tap(nextBtn());
      await tester.pump();

      expect(nextBtn(), findsNothing);
      expect(find.byKey(const Key(('result'))), findsNothing);
      await tester.enterText(priceInput(), '3659000');
      await tester.tap(checkBtn());
      await tester.pump();
      expect(nextBtn(), findsOneWidget);
      expect(find.byKey(const Key(('result'))), findsOneWidget);
      expect(find.text('fail'), findsOneWidget);

      await tester.enterText(priceInput(), '36500000');
      await tester.tap(checkBtn());
      await tester.pump();

      expect(find.text('pass'), findsOneWidget);
    });
  });
}
