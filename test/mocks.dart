import 'package:mocktail/mocktail.dart';
import 'package:modern_pageable_listview/src/domain/entities/pageable.dart';
import 'package:result_dart/result_dart.dart';

class MockLoadCallback<T extends Object> extends Mock {
  Future<Result<Pageable<T>, Exception>> call(int page, int limit);
}

class MockException implements Exception {}
