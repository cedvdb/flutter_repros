import 'package:equatable/equatable.dart';

class DiscountEntry with EquatableMixin {
  // max value eligible for discount
  final int minDays;
  // percentage
  final int discount;

  DiscountEntry({
    required this.minDays,
    required this.discount,
  })  : assert(0 <= minDays && minDays <= 365),
        assert(discount >= 0 && discount < 100);

  bool operator <(DiscountEntry other) {
    return minDays < other.minDays && discount < other.discount;
  }

  bool operator >(DiscountEntry other) {
    return minDays > other.minDays && discount > other.discount;
  }

  bool operator <=(DiscountEntry other) {
    return minDays <= other.minDays && discount <= other.discount;
  }

  bool operator >=(DiscountEntry other) {
    return minDays >= other.minDays && discount >= other.discount;
  }

  @override
  List<Object?> get props => [minDays, discount];
}
