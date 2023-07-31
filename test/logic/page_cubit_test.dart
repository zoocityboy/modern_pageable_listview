import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modern_pageable_listview/src/domain/entities/pageable.dart';
import 'package:modern_pageable_listview/src/domain/entities/post_entity.dart';
import 'package:modern_pageable_listview/src/logic/cubit/page/page_cubit.dart';
import 'package:result_dart/functions.dart';

import '../mocks.dart';

void main() {
  group('PageCubit', () {
    late MockLoadCallback<PostEntity> mockLoadCallback;
    final items = List.generate(100, (_) => PostEntity.fake());
    final successResponse = Pageable<PostEntity>(
      data: items,
      totalCount: items.length,
    );
    final failureResponse = MockException();

    setUp(() {
      mockLoadCallback = MockLoadCallback<PostEntity>();
    });

    test('initial state is PageInitial', () {
      final cubit = PageCubit<PostEntity>(
        callback: mockLoadCallback.call,
        page: 0,
      );
      expect(cubit.state, isA<PageInitial<PostEntity>>());
    });

    blocTest<PageCubit<PostEntity>, PageState<PostEntity>>(
      'fetch emits PageLoaded when callback returns success',
      build: () {
        when(() => mockLoadCallback(0, 10))
            .thenAnswer((_) async => successOf(successResponse));
        return PageCubit<PostEntity>(
          callback: mockLoadCallback.call,
          page: 0,
        );
      },
      act: (cubit) => cubit.fetch(),
      expect: () => [
        PageLoading<PostEntity>(),
        PageLoaded<PostEntity>(items: items),
      ],
    );

    blocTest<PageCubit<PostEntity>, PageState<PostEntity>>(
      'fetch emits PageFailure when callback returns failure',
      build: () {
        when(() => mockLoadCallback(0, 10))
            .thenAnswer((_) async => failureOf(failureResponse));
        return PageCubit<PostEntity>(
          callback: mockLoadCallback.call,
          page: 0,
        );
      },
      act: (cubit) => cubit.fetch(),
      expect: () => [
        PageLoading<PostEntity>(),
        PageFailure<PostEntity>(error: failureResponse),
      ],
    );
  });
}
