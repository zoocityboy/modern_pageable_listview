part of 'pageable_list_cubit.dart';

/// Represents the state of a pageable list.
///
/// Instances of this class are used to maintain the state of a pageable list,
/// where the `limit` parameter specifies the maximum number of items to be shown on each page.
///
/// Example usage:
/// ```dart
///  PageableListState<PostEntity>(limit: 20);
/// ```
sealed class PageableListState<T extends Object> extends Equatable {
  /// Creates a new instance of [PageableListState] with the specified [limit].
  ///
  /// The [limit] parameter specifies the maximum number of items to be shown on each page.
  const PageableListState({this.limit = 10});

  /// The maximum number of items to be shown on each page.
  final int limit;

  @override
  List<Object> get props => [limit];
}

/// Represents the initial state of a page
class PagableListInitial<T extends Object> extends PageableListState<T> {
  /// Creates a new instance of [PagableListInitial].
  const PagableListInitial({
    required super.limit,
  });
}

/// Represents the loading state of a page
class PagableListLoading<T extends Object> extends PageableListState<T> {}

/// Represents the loaded state of a pages
class PagableListLoaded<T extends Object> extends PageableListState<T> {
  /// Creates a new instance of [PagableListLoaded].
  const PagableListLoaded({
    required this.pages,
    required this.totalCount,
  });

  /// The list of pages
  final Map<int, PageCubit<T>> pages;

  /// The total number of items
  final int totalCount;
  @override
  List<Object> get props => [
        limit,
        pages,
        totalCount,
      ];
}

/// Represents the failure state of a page
class PagableListFailure<T extends Object> extends PageableListState<T> {
  /// Creates a new instance of [PagableListFailure].
  const PagableListFailure({
    required this.error,
  });

  /// The error object
  final Object error;
  @override
  List<Object> get props => [error, limit];
}
