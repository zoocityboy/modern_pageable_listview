part of 'pageable_list_cubit.dart';

/// type definition for API request function
typedef LoadCallback<T> = Future<Result<Pageable<T>, Exception>> Function(
  int page,
  int limit,
);
