import 'package:flutter/material.dart';

/// a button that is used on top of stacked widgets
class OverlayButton extends StatelessWidget {
  final Function() onTap;
  final Widget child;

  const OverlayButton({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      elevation: 3,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: DefaultTextStyle(
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            child: child,
          ),
        ),
      ),
    );
  }
}
