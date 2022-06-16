import 'package:flutter/material.dart';

class AppSubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final ButtonStyle? style;

  const AppSubmitButton({
    Key? key,
    required this.onPressed,
    this.style,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const ValueKey('submit'),
      onPressed: onPressed,
      child: const Text('done'),
    );
  }
}
