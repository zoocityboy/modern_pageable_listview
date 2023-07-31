import 'package:flutter/material.dart';

import 'post_loading_tile.dart';

/// Loading placeholder used before first request
class LoadingPlaceholderWidget extends StatelessWidget {
  /// Loading placeholder used before first request
  const LoadingPlaceholderWidget({required this.count, super.key});
  final int count;

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList.builder(
      itemExtent: 90,
      itemBuilder: (context, index) {
        return Card(
          key: Key('initial_placeholder_$index'),
          child: const PostLoadingTile(),
        );
      },
      itemCount: count,
    );
  }
}
