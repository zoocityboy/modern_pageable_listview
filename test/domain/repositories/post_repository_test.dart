import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modern_pageable_listview/src/domain/entities/pageable.dart';
import 'package:modern_pageable_listview/src/domain/entities/post_entity.dart';
import 'package:modern_pageable_listview/src/domain/repositories/post_repository.dart';
import 'package:result_dart/functions.dart';

import '../../mocks.dart';


void main() {
  group('PostRepository', () {
    late int totalCount;
    late int pageSize;
    late IPostRepository repository;
    late Pageable<PostEntity> response;
    setUp(() {
      registerFallbackValue(PostEntity.fake());
      repository = MockPostRepository();
      pageSize = 10;
      totalCount = 200;
      response = Pageable<PostEntity>(
        data: List.generate(pageSize, (index) => PostEntity.fake()),
        pageSize: pageSize,
        totalCount: totalCount,
      );
    });
    test('list should return success result with correct page data', () async {
      // Arrange
      when(
        () => repository.list(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => successOf(response));

      // Act
      final result = await repository.list();

      // Assert
      expect(result.isSuccess(), isTrue); // Check if the result is a success
      expect(
        result.getOrThrow().page,
        0,
      ); // Check if the returned page is correct
      expect(
        result.getOrThrow().pageSize,
        pageSize,
      ); // Check if the returned page size is correct
      expect(
        result.getOrThrow().totalCount,
        totalCount,
      ); // Check if the total count is correct
    });

    test('list should return failure result when out of range', () async {
      // Arrange
      final repo =
          PostRepository(5); // Create an instance of the PostRepository class

      // Act
      final result = await repo.list(page: 1);

      // Assert
      expect(result.isError(), isTrue); // Check if the result is a failure

      // Check if the error is of type Exception
      result.fold((data) {}, (error) {
        expect(error, isA<Exception>());
      });
    });
  });
}
