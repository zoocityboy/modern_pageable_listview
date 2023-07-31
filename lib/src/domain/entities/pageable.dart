// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../logic/cubit/page/page_cubit.dart';
import '../../logic/cubit/pageable/pageable_list_cubit.dart';

/// Pageable object for responses
class Pageable<T> extends Equatable {
  /// Total number of items available on server
  final int totalCount;

  /// Current page
  final int page;

  /// Number of items per [page]
  final int pageSize;

  /// List of items
  final List<T> data;
  const Pageable({
    this.totalCount = 0,
    this.page = 0,
    this.pageSize = 10,
    this.data = const [],
  });

  /// Creates a Pageable object
  factory Pageable.empty() => const Pageable(
        pageSize: 0,
      );

  @override
  List<Object?> get props => [
        totalCount,
        page,
        pageSize,
        data,
      ];

  /// Calculate total pages from [totalCount] and [pageSize]
  int get totalPages => totalCount ~/ pageSize;
  @override
  String toString() {
    return 'Pageable<$T>{totalCount: $totalCount, page: $page, pageSize: $pageSize, data: ...}';
  }
}

extension ConvertPageable<T extends Object> on Pageable<T> {
  Map<int, PageCubit<T>> convert(int limit, LoadCallback<T> callback) {
    return List<PageCubit<T>>.generate(totalPages, (index) {
      return PageCubit<T>(
        callback: callback,
        // first page will be added directly without fetching new data
        items: index == 0 ? data : null,
        page: index,
        limit: limit,
      );
    }).asMap();
  }
}
