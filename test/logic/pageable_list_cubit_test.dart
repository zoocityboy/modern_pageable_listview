import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modern_pageable_listview/src/domain/entities/pageable.dart';
import 'package:modern_pageable_listview/src/domain/entities/post_entity.dart';
import 'package:modern_pageable_listview/src/logic/cubit/pageable/pageable_list_cubit.dart';
import 'package:result_dart/functions.dart';

import '../mocks.dart';

void main() {
  group('PageableListCubit', () {
    late MockLoadCallback<PostEntity> fakeCallback;

    final items = List.generate(100, (_) => PostEntity.fake());
    final successResponse = Pageable<PostEntity>(
      data: items,
      totalCount: items.length,
    );
    final failureResponse = Exception('Error occurred');

    setUp(
      () {
        fakeCallback = MockLoadCallback<PostEntity>();
      },
    );

    test('initial state is PagableListInitial', () {
      final cubit =
          PageableListCubit<PostEntity>(apiRequest: fakeCallback.call);
      expect(cubit.state, isA<PageableListInitial>());
    });

    blocTest<PageableListCubit<PostEntity>, PageableListState<PostEntity>>(
      'emits PagableListLoaded when initialize is called successfully',
      build: () {
        when(() => fakeCallback.call(0, any()))
            .thenAnswer((_) async => successOf(successResponse));
        return PageableListCubit<PostEntity>(apiRequest: fakeCallback.call);
      },
      act: (PageableListCubit<PostEntity> cubit) {
        cubit.initialize();
      },
      expect: () => [
        PageableListLoading<PostEntity>(),
        isA<PageableListLoaded<PostEntity>>(),
      ],
    );

    blocTest<PageableListCubit<PostEntity>, PageableListState<PostEntity>>(
      'emits PagableListFailure when initialize fails',
      build: () {
        when(() => fakeCallback.call(0, any()))
            .thenAnswer((_) async => failureOf(failureResponse));
        return PageableListCubit<PostEntity>(apiRequest: fakeCallback.call);
      },
      act: (PageableListCubit<PostEntity> cubit) {
        cubit.initialize();
      },
      expect: () => [
        PageableListLoading<PostEntity>(),
        PageableListFailure<PostEntity>(error: failureResponse),
      ],
    );

    blocTest<PageableListCubit<PostEntity>, PageableListState<PostEntity>>(
      'emits PagableListLoading when reset is called',
      build: () {
        when(() => fakeCallback.call(0, any()))
            .thenAnswer((_) async => successOf(successResponse));
        return PageableListCubit<PostEntity>(apiRequest: fakeCallback.call);
      },
      act: (PageableListCubit<PostEntity> cubit) {
        cubit.reset();
      },
      expect: () => [
        PageableListLoading<PostEntity>(),
        isA<PageableListLoaded<PostEntity>>(),
      ],
    );
  });
}
