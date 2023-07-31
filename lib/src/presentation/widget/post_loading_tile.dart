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
    final color = Colors.grey.shade200;
    final decoration =
        BoxDecoration(borderRadius: BorderRadius.circular(4), color: color);
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surface,
        ),
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
      ),
      // .animate(
      //   onPlay: (controller) => controller.repeat(),
      // )
      // .shimmer(
      //   blendMode: BlendMode.dstATop,
      //   color: Colors.white12,
      //   duration: const Duration(milliseconds: 1500),
      // ),
    );
  }
}
