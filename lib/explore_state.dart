import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

const pageStateParis =
    PageState(position: LatLng(48.8566, 2.3522), itemCount: 30);
const pageStateNewYork =
    PageState(position: LatLng(40.7128, 74.0060), itemCount: 0);

final stateController = BehaviorSubject.seeded(pageStateParis);

void toggleState() {
  final nextState = stateController.value == pageStateParis
      ? pageStateNewYork
      : pageStateParis;
  stateController.add(nextState);
}

class PageState {
  final LatLng position;
  final int itemCount;
  const PageState({
    required this.position,
    required this.itemCount,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PageState &&
        other.position == position &&
        other.itemCount == itemCount;
  }

  @override
  int get hashCode => position.hashCode ^ itemCount.hashCode;
}
