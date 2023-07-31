import 'package:flutter_animate/flutter_animate.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

import '../entities/pageable.dart';
import '../entities/post_entity.dart';

/// Post repository fakes API requests
/// every time a new page is requested
/// the response is returned after delay
class PostRepository extends IPostRepository {
  /// Post repository fakes API requests
  PostRepository(int length) {
    _pageable = Pageable<PostEntity>(
      totalCount: length,
      data: List.generate(length, (index) => PostEntity.fake()),
    );
  }
  late final Pageable<PostEntity> _pageable;

  /// Fake API query with response wrapped to Result object
  /// every time a new page is requested
  @override
  Future<Result<Pageable<PostEntity>, Exception>> list({
    int page = 0,
    int limit = 10,
  }) async {
    await Future<void>.delayed(300.ms);
    final from = page * limit;
    final to = (page + 1) * limit;
    if (to >= _pageable.totalCount) {
      return failureOf(Exception('Out of range'));
    }
    return successOf(
      Pageable<PostEntity>(
        page: page,
        pageSize: limit,
        totalCount: _pageable.totalCount,
        data: _pageable.data.sublist(from, to),
      ),
    );
  }
}

/// Post repository fakes API requests
/// every time a new page is requested
/// the response is returned after delay
abstract class IPostRepository {
  /// Fake API query with response wrapped to Result object
  Future<Result<Pageable<PostEntity>, Exception>> list({
    int page = 0,
    int limit = 10,
  });
}
