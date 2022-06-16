import 'package:flutter/material.dart';
import 'package:flutter_repros/discount_entry.dart';
import 'package:flutter_repros/discount_list.dart';
import 'package:flutter_repros/discount_table_field.dart';
import 'package:flutter_repros/internal/app_submit_button.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildDiscountTable({
  required DiscountList initialValue,
  required ValueChanged<DiscountList> onChange,
}) =>
    MaterialApp(
      home: Scaffold(
        body: DiscountTableField(
          initialValue: initialValue,
          onChange: onChange,
        ),
      ),
    );

class WidgetUser {
  static Future<void> clickEmptyCell(WidgetTester tester) async {
    await tester.tap(find.text('-').first);
    await tester.pumpAndSettle();
  }

  static Future<void> clickDone(WidgetTester tester) async {
    await tester.tap(find.byType(AppSubmitButton));
    await tester.pumpAndSettle();
  }

  static Future<void> clickIncrease(WidgetTester tester) async {
    await tester.tap(find.byKey(const ValueKey('increase-button')));
    await tester.pumpAndSettle();
  }

  static Future<void> clickDecrease(WidgetTester tester) async {
    await tester.tap(find.byKey(const ValueKey('decrease-button')));
    await tester.pumpAndSettle();
  }

  static Future<void> verifyDecreaseEnabled(WidgetTester tester) async {
    var decreaseButton = tester
        .widget<IconButton>(find.byKey(const ValueKey('decrease-button')));
    expect(decreaseButton.onPressed, isNot(null));
  }

  static Future<void> verifyDecreaseDisabled(WidgetTester tester) async {
    var decreaseButton = tester
        .widget<IconButton>(find.byKey(const ValueKey('decrease-button')));
    expect(decreaseButton.onPressed, equals(null));
  }

  static Future<void> verifyIncreaseEnabled(WidgetTester tester) async {
    var decreaseButton = tester
        .widget<IconButton>(find.byKey(const ValueKey('increase-button')));
    expect(decreaseButton.onPressed, isNot(null));
  }

  static Future<void> verifyIncreaseDisabled(WidgetTester tester) async {
    var decreaseButton = tester
        .widget<IconButton>(find.byKey(const ValueKey('increase-button')));
    expect(decreaseButton.onPressed, equals(null));
  }
}

void main() {
  group('DiscountTableField', () {
    testWidgets('Should be able to add entries with default values',
        (tester) async {
      List<DiscountEntry> entries = [];
      await tester.pumpWidget(
        buildDiscountTable(
          initialValue: DiscountList([]),
          onChange: (newEntries) => entries = newEntries,
        ),
      );
      // click left cell
      await WidgetUser.clickEmptyCell(tester);
      await WidgetUser.clickDone(tester);

      // click right cell
      await WidgetUser.clickEmptyCell(tester);
      await WidgetUser.clickDone(tester);

      expect(entries.length, equals(1));
      expect(entries.last.minDays, equals(5));
      expect(entries.last.discount, equals(5));
      // a new empty entry should be created
      await WidgetUser.clickEmptyCell(tester);
      await WidgetUser.clickDone(tester);

      await WidgetUser.clickEmptyCell(tester);
      await WidgetUser.clickDone(tester);

      expect(entries.length, equals(2));
      expect(entries.last.minDays, equals(10));
      expect(entries.last.discount, equals(10));
    });

    testWidgets('Should be able to add entries with manual values',
        (tester) async {
      List<DiscountEntry> entries = [];
      await tester.pumpWidget(
        buildDiscountTable(
          initialValue: DiscountList([]),
          onChange: (newEntries) => entries = newEntries,
        ),
      );
      await WidgetUser.clickEmptyCell(tester);
      await WidgetUser.clickIncrease(tester);
      await WidgetUser.clickDone(tester);

      await WidgetUser.clickEmptyCell(tester);
      await WidgetUser.clickIncrease(tester);
      await WidgetUser.clickDone(tester);

      expect(entries.length, equals(1));
      expect(entries.last.minDays, equals(10));
      expect(entries.last.discount, equals(10));
    });

    testWidgets('Should be able to start with an initial value',
        (tester) async {
      await tester.pumpWidget(
        buildDiscountTable(
          initialValue: DiscountList([
            DiscountEntry(minDays: 5, discount: 10),
            DiscountEntry(minDays: 15, discount: 20),
          ]),
          onChange: (newEntries) {},
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('-'), findsNWidgets(2));
      expect(find.text('5'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
      expect(find.text('20'), findsOneWidget);
    });

    testWidgets('Should not be able to go below minimum', (tester) async {
      await tester.pumpWidget(
        buildDiscountTable(
          initialValue: DiscountList([]),
          onChange: (newEntries) {},
        ),
      );
      await WidgetUser.clickEmptyCell(tester);
      await WidgetUser.verifyDecreaseDisabled(tester);
      await WidgetUser.clickIncrease(tester);
      await WidgetUser.verifyDecreaseEnabled(tester);
    });

    testWidgets('Should not be able to go above maximum', (tester) async {
      await tester.pumpWidget(
        buildDiscountTable(
          initialValue: DiscountList([]),
          onChange: (newEntries) {},
        ),
      );
      await WidgetUser.clickEmptyCell(tester);
      // starts at 5, max is 100 so 95 to go, equals 19 clicks
      const remainingClicks = (DiscountEntry.maxMinDays / 5) - 1;
      for (var i = 0; i < remainingClicks; i++) {
        await WidgetUser.clickIncrease(tester);
      }
      await WidgetUser.verifyIncreaseDisabled(tester);
    });

    testWidgets('Should be able to remove an entry', (tester) async {
      var entries = DiscountList([
        DiscountEntry(minDays: 5, discount: 10),
        DiscountEntry(minDays: 15, discount: 20),
      ]);
      await tester.pumpWidget(
        buildDiscountTable(
          initialValue: entries,
          onChange: (newEntries) => entries = newEntries,
        ),
      );
      await tester.tap(find.byIcon(Icons.close).first);
      await tester.pumpAndSettle();
      expect(entries.length, equals(1));
    });

    testWidgets('Should be able to edit an entry', (tester) async {
      await tester.pumpWidget(
        buildDiscountTable(
          initialValue: DiscountList([
            DiscountEntry(minDays: 5, discount: 20),
          ]),
          onChange: (newEntries) {},
        ),
      );
      await tester.tap(find.text('5'));
      await tester.pumpAndSettle();
      await WidgetUser.clickIncrease(tester);
      await WidgetUser.clickDone(tester);

      expect(find.text('5'), findsNothing);
      expect(find.text('10'), findsOneWidget);

      await tester.tap(find.text('20'));
      await tester.pumpAndSettle();
      await WidgetUser.clickIncrease(tester);
      await WidgetUser.clickDone(tester);

      expect(find.text('20'), findsNothing);
      expect(find.text('25'), findsOneWidget);
    });

    testWidgets(
        'Should not be able to edit an entry that is locked because of other entries',
        (tester) async {
      await tester.pumpWidget(
        buildDiscountTable(
          initialValue: DiscountList([
            // 5 is the minimum and the next item has 10 minDays
            // so we cannot increase to 10
            DiscountEntry(minDays: 5, discount: 20),
            DiscountEntry(minDays: 10, discount: 25),
          ]),
          onChange: (newEntries) {},
        ),
      );
      await tester.tap(find.text('5'));
      await tester.pumpAndSettle();
      await WidgetUser.verifyDecreaseDisabled(tester);
      await WidgetUser.verifyIncreaseDisabled(tester);
    });

    testWidgets('Should not allow new lines if the max has been reached',
        (tester) async {
      const beforeMax = DiscountEntry.maxMinDays - 5;
      await tester.pumpWidget(
        buildDiscountTable(
          initialValue: DiscountList([
            // 5 is the minimum and the next item has 10 minDays
            // so we cannot increase to 10
            DiscountEntry(minDays: 5, discount: 20),
            DiscountEntry(minDays: beforeMax, discount: 25),
          ]),
          onChange: (newEntries) {},
        ),
      );
      expect(find.text('-'), findsWidgets);
      await tester.tap(find.text(beforeMax.toString()));
      await WidgetUser.clickIncrease(tester);
      await WidgetUser.clickDone(tester);
      expect(find.text('-'), findsNothing);
    });
  });
}
