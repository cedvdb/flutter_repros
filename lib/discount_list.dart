import 'dart:collection';

import 'discount_entry.dart';

class DiscountList
    with ListMixin<DiscountEntry>
    implements List<DiscountEntry> {
  final List<DiscountEntry> _entries = [];

  @override
  int get length => _entries.length;
  @override
  set length(int length) => _entries.length = length;

  DiscountList([List<DiscountEntry> entries = const []])
      : assert(entries.length <= 5) {
    for (var entry in entries) {
      _entries.add(entry);
    }
  }

  @override
  DiscountEntry operator [](int index) {
    return _entries[index];
  }

  @override
  void operator []=(int index, DiscountEntry entry) {
    if (index > 0 && entry < last) {
      throw UnsupportedError('cannot add discount entry <= than previous');
    }
    if (index < length && entry > last) {
      throw UnsupportedError('cannot add discount entry >= next value');
    }
    _entries[index] = entry;
  }
}
