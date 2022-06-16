import 'package:flutter/material.dart';
import 'package:flutter_repros/discount_entry.dart';
import 'package:flutter_repros/discount_list.dart';
import 'package:flutter_repros/discount_table_field.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildDiscountTable({
  required DiscountList initialValue,
  required ValueChanged<List<DiscountEntry>> onChange,
}) =>
    MaterialApp(
      home: Scaffold(
        body: DiscountTableField(
          initialValue: initialValue,
          onChange: onChange,
        ),
      ),
    );

void main() {
  group('DiscountTableField', () {
    testWidgets('Should be able to add entries with default values',
        (tester) async {
      late List<DiscountEntry> entries;
      await tester.pumpWidget(
        buildDiscountTable(
          initialValue: DiscountList([]),
          onChange: (newEntries) => entries = newEntries,
        ),
      );
      // click left cell
      await tester.tap(find.text('-').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('done'));
      await tester.pumpAndSettle();

      // click right cell
      await tester.tap(find.text('-'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('done'));
      await tester.pumpAndSettle();

      expect(entries.length, equals(1));
      expect(entries.first.minDays, equals(5));
      expect(entries.first.discount, equals(5));
      // a new empty entry should be created
      await tester.tap(find.text('-').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('done'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('-'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('done'));
      await tester.pumpAndSettle();

      expect(entries.length, equals(2));
      expect(entries.first.minDays, equals(10));
      expect(entries.first.discount, equals(10));
    });

    testWidgets('Should be able to add entries with manual values',
        (tester) async {
      late List<DiscountEntry> entries;
      await tester.pumpWidget(
        buildDiscountTable(
          initialValue: DiscountList([]),
          onChange: (newEntries) => entries = newEntries,
        ),
      );
      await tester.tap(find.text('-').first);
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.remove), findsNothing);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.tap(find.text('done'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('-'));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.remove), findsNothing);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.tap(find.text('done'));
      await tester.pumpAndSettle();

      expect(entries.length, equals(1));
      expect(entries.first.minDays, equals(10));
      expect(entries.first.discount, equals(10));
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

      expect(find.byType(DataRow), findsNWidgets(3));
      expect(find.text('-'), findsNWidgets(2));
      expect(find.text('5'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
      expect(find.text('20'), findsOneWidget);
    });

    testWidgets('Should be able to remove an entry', (tester) async {
      await tester.pumpWidget(
        buildDiscountTable(
          initialValue: DiscountList([
            DiscountEntry(minDays: 5, discount: 10),
            DiscountEntry(minDays: 15, discount: 20),
          ]),
          onChange: (newEntries) {},
        ),
      );
      expect(find.byType(DataRow), findsNWidgets(3));
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pumpAndSettle();
      expect(find.byType(DataRow), findsNWidgets(2));
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
      await tester.tap(find.byIcon(Icons.add));
      await tester.tap(find.text('done'));
      expect(find.text('5'), findsNothing);
      expect(find.text('10'), findsOneWidget);
    });

    testWidgets(
        'Should not be able to edit an entry that is locked because of other entries',
        (tester) async {
      await tester.pumpWidget(
        buildDiscountTable(
          initialValue: DiscountList([
            // 5 is the minimum and the next item has 10 minDays so we cannot increase to 10 instead too
            DiscountEntry(minDays: 5, discount: 20),
            DiscountEntry(minDays: 10, discount: 25),
          ]),
          onChange: (newEntries) {},
        ),
      );
      await tester.tap(find.text('5'));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.add), findsNothing);
      expect(find.byIcon(Icons.remove), findsNothing);
    });
  });
}
