import 'package:flutter/material.dart';

import '../../domain/entities/post_entity.dart';

/// Post widget used as a ListTile
class PostTile extends StatelessWidget {
  /// Post widget used as a ListTile with a post as [item]
  const PostTile({
    required this.item,
    required this.indexOnPage,
    required this.page,
    super.key,
  });

  /// Page index
  final int page;

  /// index of item in page data
  final int indexOnPage;

  /// Content of the post
  final PostEntity item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        item.body,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
