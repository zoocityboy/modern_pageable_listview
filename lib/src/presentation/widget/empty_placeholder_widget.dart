import 'package:flutter/material.dart';

/// Empty state widget used in case of empty list
class EmptyPlaceholderWidget extends StatelessWidget {
  /// Empty state widget used in case of empty list
  const EmptyPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning_rounded,
            size: 64,
          ),
          Text(
            'Nothing here',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
