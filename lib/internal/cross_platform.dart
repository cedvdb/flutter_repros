import 'package:flutter/material.dart' hide showBottomSheet;

/// helper class to display bottom sheets that look good on any platform
abstract class CrossPlatform {
  static Future<T?> showBottomSheet<T>(
    BuildContext context,
    Widget Function(BuildContext) builder, {
    double? height,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 900) {
      return showDialog<T>(
        context: context,
        useRootNavigator: true,
        builder: (ctx) => Dialog(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: SingleChildScrollView(
              child: builder(ctx),
            ),
          ),
        ),
      );
    }
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      constraints: height != null
          ? BoxConstraints.expand(height: height)
          : BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 2,
              minWidth: double.infinity,
            ),
      builder: (ctx) => SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(ctx).viewInsets.copyWith(left: 0, right: 0),
          child: builder(context),
        ),
      ),
    );
  }

  static void pop(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pop();
}
