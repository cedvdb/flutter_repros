import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_repros/discount_entry.dart';

class DiscountValue {
  int? minDays;
  int? discount;

  DiscountValue({required this.minDays, required this.discount});

  DiscountValue.empty()
      : minDays = null,
        discount = null;

  bool get isValid => minDays != null && discount != null;
}

class DiscountTableField extends StatefulWidget {
  final List<DiscountEntry> initialValue;

  const DiscountTableField({
    Key? key,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<DiscountTableField> createState() => _DiscountTableFieldState();
}

class _DiscountTableFieldState extends State<DiscountTableField> {
  List<DiscountEntry> entries = [];
  DiscountValue nextEntry = DiscountValue.empty();

  @override
  void initState() {
    entries = widget.initialValue;
    super.initState();
  }

  void _showDaysPicker(BuildContext context) {
    const min = 5;
    setState(() => nextEntry.minDays = min);
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (ctx) => NumberStepperField(
        max: 100,
        min: min,
        onChange: (value) => setState(() => nextEntry.minDays = value),
      ),
    );
  }

  void _showDiscountPicker(BuildContext context) {
    const min = 5;
    setState(() => nextEntry.discount = min);
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (ctx) => NumberStepperField(
        max: 50,
        min: min,
        onChange: (value) => setState(() => nextEntry.discount = value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DataTable(
          columns: const [
            DataColumn(label: Text('min days')),
            DataColumn(label: Text('discount')),
          ],
          rows: [
            for (final entry in entries)
              DataRow(
                cells: [
                  DataCell(
                    Text(entry.maxValue.toString()),
                  ),
                  DataCell(
                    Text(entry.discount.toString()),
                  ),
                ],
              ),
            DataRow(
              cells: [
                DataCell(
                  Text((nextEntry.minDays ?? '-').toString()),
                  onTap: () => _showDaysPicker(context),
                ),
                DataCell(
                  Text((nextEntry.discount ?? '-').toString()),
                  onTap: () => _showDiscountPicker(context),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class NumberStepperField extends StatefulWidget {
  final int max;
  final int min;
  final int step;
  final ValueChanged<int> onChange;

  const NumberStepperField({
    Key? key,
    required this.min,
    required this.max,
    required this.onChange,
    this.step = 5,
  }) : super(key: key);

  @override
  State<NumberStepperField> createState() => _NumberStepperFieldState();
}

class _NumberStepperFieldState extends State<NumberStepperField> {
  int _value = 0;

  @override
  void initState() {
    _value = widget.min;
    super.initState();
  }

  void _add() {
    setState(() {
      _value = min(widget.max, _value + widget.step);
    });
    widget.onChange(_value);
  }

  void _substract() {
    setState(() {
      _value = max(widget.min, _value - widget.step);
    });
    widget.onChange(_value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: _substract,
          icon: const Icon(Icons.remove),
        ),
        Text(_value.toString()),
        IconButton(
          onPressed: _add,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
