import 'package:equatable/equatable.dart';

class DiscountEntry with EquatableMixin {
  // max value eligible for discount
  final int maxValue;
  // percentage
  final int discount;

  DiscountEntry({
    required this.maxValue,
    required this.discount,
  })  : assert(0 <= maxValue && maxValue <= 365),
        assert(discount >= 0 && discount < 100);

  bool operator <(DiscountEntry other) {
    return maxValue < other.maxValue && discount < other.discount;
  }

  bool operator >(DiscountEntry other) {
    return maxValue > other.maxValue && discount > other.discount;
  }

  bool operator <=(DiscountEntry other) {
    return maxValue <= other.maxValue && discount <= other.discount;
  }

  bool operator >=(DiscountEntry other) {
    return maxValue >= other.maxValue && discount >= other.discount;
  }

  @override
  List<Object?> get props => [maxValue, discount];
}
