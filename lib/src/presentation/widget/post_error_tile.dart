// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

/// Sample Post widget used as a ListTile
class PostErrorTile extends StatefulWidget {
  /// Sample Post widget used as a ListTile
  const PostErrorTile({
    required this.error,
    super.key,
  });

  /// Error
  final Object error;

  @override
  State<PostErrorTile> createState() => _PostErrorTileState();
}

class _PostErrorTileState extends State<PostErrorTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text('error: ${widget.error};'));
  }
}
