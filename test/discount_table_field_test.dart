import 'package:flutter/material.dart';
import 'package:flutter_repros/discount_entry.dart';
import 'package:flutter_repros/discount_table_field.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildDiscountTable({
  required List<DiscountEntry> initialValue,
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
          initialValue: [],
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
          initialValue: [],
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
          initialValue: [
            DiscountEntry(minDays: 5, discount: 5),
            DiscountEntry(minDays: 10, discount: 15),
          ],
          onChange: (newEntries) {},
        ),
      );
    });

    testWidgets('Should be able to remove an entry', (tester) async {});

    testWidgets('Should be able to edit an entry', (tester) async {});

    testWidgets('should not be able to go above 100 days', (tester) async {});
  });
}
