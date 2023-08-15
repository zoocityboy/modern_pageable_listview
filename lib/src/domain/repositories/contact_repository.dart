import 'package:flutter_animate/flutter_animate.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

import '../entities/contact_entity.dart';
import '../entities/pageable.dart';

/// Contact repository fakes API requests
/// every time a new page is requested
/// the response is returned after delay
class ContactRepository extends IContactRepository {
  /// Post repository fakes API requests
  ContactRepository(int length) {
    _pageable = Pageable<ContactEntity>(
      totalCount: length,
      data: List.generate(length, (index) => ContactEntity.fake()),
    );
  }
  late final Pageable<ContactEntity> _pageable;

  /// Fake API query with response wrapped to Result object
  /// every time a new page is requested
  @override
  Future<Result<Pageable<ContactEntity>, Exception>> list({
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
      Pageable<ContactEntity>(
        page: page,
        pageSize: limit,
        totalCount: _pageable.totalCount,
        data: _pageable.data.sublist(from, to),
      ),
    );
  }
}

/// Contact repository fakes API requests
/// every time a new page is requested
/// the response is returned after delay
// ignore: one_member_abstracts
abstract class IContactRepository {
  /// Fake API query with response wrapped to Result object
  Future<Result<Pageable<ContactEntity>, Exception>> list({
    int page = 0,
    int limit = 10,
  });
}
