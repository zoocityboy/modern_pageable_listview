import 'package:result_dart/result_dart.dart';

import '../entities/pageable.dart';

/// type definition for API request function
typedef LoadCallback<T> = Future<Result<Pageable<T>, Exception>> Function(
  int page,
  int limit,
);
