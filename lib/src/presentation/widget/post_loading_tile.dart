import 'package:flutter/material.dart';

/// Sample Post widget used as a ListTile
class PostLoadingTile extends StatefulWidget {
  /// Sample Post widget used as a ListTile
  const PostLoadingTile({super.key});

  @override
  State<PostLoadingTile> createState() => _PostLoadingTileState();
}

class _PostLoadingTileState extends State<PostLoadingTile> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.outlineVariant;
    final decoration =
        BoxDecoration(borderRadius: BorderRadius.circular(4), color: color);
    return SizedBox.expand(
      child: ListTile(
        title: Container(
          decoration: decoration,
          height: 20,
          width: 120,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 4,
            ),
            Container(
              decoration: decoration,
              height: 16,
              width: 200,
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              decoration: decoration,
              height: 16,
              width: 180,
            ),
          ],
        ),
      ),
    );
  }
}
