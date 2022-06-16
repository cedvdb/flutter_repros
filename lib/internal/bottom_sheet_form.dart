import 'package:flutter/material.dart';

import 'app_submit_button.dart';
import 'cross_platform.dart';

class BottomSheetForm extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onSubmit;

  /// whether what's under the title receives padding
  final bool contentPadding;
  final bool showSubmitButton;

  const BottomSheetForm({
    Key? key,
    required this.title,
    required this.child,
    required this.onSubmit,
    this.showSubmitButton = true,
    this.contentPadding = false,
  }) : super(key: key);

  void _submit(BuildContext context) {
    CrossPlatform.pop(context);
    onSubmit?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
            bottom: 0,
          ),
          child: Text(
            title,
          ),
        ),
        const SizedBox(height: 4),
        if (contentPadding)
          Padding(
            padding: const EdgeInsets.all(8),
            child: child,
          ),
        if (!contentPadding) ...[
          child,
          const SizedBox(height: 8),
        ],
        if (showSubmitButton)
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AppSubmitButton(onPressed: () => _submit(context)),
            ),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}
