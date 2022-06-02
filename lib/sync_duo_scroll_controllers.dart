import 'dart:math';

import 'package:flutter/cupertino.dart';

class SyncDuoScrollControllers {
  final ScrollController left = ScrollController();
  final ScrollController right = ScrollController();

  void link() {
    left.addListener(_onLeftScrolled);
    right.addListener(_onRightScrolled);
  }

  void unlink() {
    left.removeListener(_onLeftScrolled);
    right.removeListener(_onRightScrolled);
  }

  void _onLeftScrolled() {
    _synchronize(right, to: left.offset);
  }

  void _onRightScrolled() {
    _synchronize(left, to: right.offset);
  }

  void _synchronize(ScrollController controller, {required double to}) {
    final maxOffset = controller.position.maxScrollExtent;
    final offset = min(to, maxOffset);
    controller.jumpTo(offset);
  }
}
