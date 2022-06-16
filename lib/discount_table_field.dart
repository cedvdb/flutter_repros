// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_repros/discount_entry.dart';
import 'package:flutter_repros/discount_list.dart';
import 'package:flutter_repros/internal/bottom_sheet_form.dart';
import 'package:flutter_repros/internal/cross_platform.dart';

class DiscountItem {
  int? minDays;
  int? discount;

  DiscountItem({required this.minDays, required this.discount});

  DiscountItem.empty()
      : minDays = null,
        discount = null;

  DiscountItem.fromEntry(DiscountEntry entry)
      : minDays = entry.minDays,
        discount = entry.discount;

  bool get isValid => minDays != null && discount != null;

  bool get isEmpty => minDays == null && discount == null;
  bool get isNotEmpty => !isEmpty;

  bool get isMax =>
      minDays == DiscountEntry.maxMinDays ||
      discount == DiscountEntry.maxDiscount;

  bool get isNotMax => !isMax;

  @override
  String toString() => 'DiscountValue(minDays: $minDays, discount: $discount)';
}

class DiscountTableField extends StatefulWidget {
  final DiscountList initialValue;
  final ValueChanged<List<DiscountEntry>> onChange;

  const DiscountTableField({
    Key? key,
    required this.initialValue,
    required this.onChange,
  }) : super(key: key);

  @override
  State<DiscountTableField> createState() => _DiscountTableFieldState();
}

class _DiscountTableFieldState extends State<DiscountTableField> {
  static const step = 5;
  List<DiscountItem> _items = [];

  @override
  void initState() {
    _items = widget.initialValue.map(DiscountItem.fromEntry).toList();
    _items.add(DiscountItem.empty());
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    _onChange();
  }

  void _onChange() {
    if (_items.isEmpty || (_items.last.isValid && _items.last.isNotMax)) {
      setState(() => _items.add(DiscountItem.empty()));
    }
  }

  void _showDaysPicker(BuildContext context, DiscountItem item) {
    final itemIndex = _items.indexOf(item);
    final isFirstItem = itemIndex == 0;
    final isLastItem = itemIndex == _items.length - 1;
    final previousItem = isFirstItem ? null : _items[itemIndex - 1];
    final nextItem = isLastItem ? null : _items[itemIndex + 1];
    // the minimum is a step above the previous item
    var min = step;
    if (!isFirstItem) {
      min = previousItem!.minDays! + step;
    }
    // the maximum is a step below the next item
    var max = DiscountEntry.maxMinDays;
    if (!isLastItem && nextItem!.minDays != null) {
      max = (nextItem.minDays! - step);
    }
    int newValue = min;
    CrossPlatform.showBottomSheet(
      context,
      (ctx) => BottomSheetForm(
        title: 'Min days',
        onSubmit: () => setState(() => item.minDays = newValue),
        child: NumberStepperField(
          initialValue: item.minDays,
          min: min,
          max: max,
          onChange: (newMinDays) => newValue = newMinDays,
        ),
      ),
    );
  }

  void _showDiscountPicker(BuildContext context, DiscountItem item) {
    final itemIndex = _items.indexOf(item);
    final isFirstItem = itemIndex == 0;
    final isLastItem = itemIndex == _items.length - 1;
    final previousItem = isFirstItem ? null : _items[itemIndex - 1];
    final nextItem = isLastItem ? null : _items[itemIndex + 1];
    // the minimum is a step above the previous item
    var min = step;
    if (!isFirstItem) {
      min = previousItem!.discount! + step;
    }
    // the maximum is a step below the next item
    var max = DiscountEntry.maxDiscount;
    if (!isLastItem && nextItem!.discount != null) {
      max = (nextItem.discount! - step);
    }
    int newValue = min;

    // if there is no value for min days we set the min    setState(() => value.discount ??= min);
    CrossPlatform.showBottomSheet(
      context,
      (ctx) => BottomSheetForm(
        title: 'Discount (%)',
        onSubmit: () => setState(() => item.discount = newValue),
        child: NumberStepperField(
          initialValue: item.discount,
          min: min,
          max: max,
          onChange: (newDiscount) => newValue = newDiscount,
        ),
      ),
    );
  }

  void _remove(DiscountItem item) {
    setState(() {
      _items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DataTable(
          columns: const [
            DataColumn(label: Text('min days')),
            DataColumn(label: Text('discount')),
            DataColumn(label: SizedBox(width: 24)),
          ],
          rows: [
            for (final item in _items)
              DataRow(
                cells: [
                  DataCell(
                    onTap: () => _showDaysPicker(context, item),
                    Text((item.minDays ?? '-').toString()),
                  ),
                  DataCell(
                    onTap: () => _showDiscountPicker(context, item),
                    Text((item.discount ?? '-').toString()),
                  ),
                  DataCell(
                    item.isValid
                        ? IconButton(
                            onPressed: () => _remove(item),
                            icon: const Icon(Icons.close, size: 16),
                          )
                        : Container(),
                  ),
                ],
              ),
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
  final int? initialValue;
  final ValueChanged<int> onChange;

  const NumberStepperField({
    Key? key,
    required this.min,
    required this.max,
    required this.onChange,
    required this.initialValue,
    this.step = 5,
  }) : super(key: key);

  @override
  State<NumberStepperField> createState() => _NumberStepperFieldState();
}

class _NumberStepperFieldState extends State<NumberStepperField> {
  int _value = 0;

  @override
  void initState() {
    _value = widget.initialValue ?? widget.min;
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
          onPressed: _value == widget.min ? null : _substract,
          icon: const Icon(Icons.remove),
        ),
        Text(_value.toString()),
        IconButton(
          onPressed: _value == widget.max ? null : _add,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
