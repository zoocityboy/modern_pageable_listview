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
    final fakeCallback = MockLoadCallback<PostEntity>();
    final cubit = PageableListCubit<PostEntity>(callback: fakeCallback.call);
    final items = List.generate(100, (_) => PostEntity.fake());
    final successResponse = Pageable<PostEntity>(
      data: items,
      totalCount: items.length,
    );
    final failureResponse = Exception('Error occurred');

    setUp(
      () {},
    );

    tearDown(cubit.close);

    test('initial state is PagableListInitial', () {
      expect(cubit.state, isA<PagableListInitial>());
    });

    blocTest<PageableListCubit<PostEntity>, PageableListState<PostEntity>>(
      'emits PagableListLoaded when initialize is called successfully',
      build: () {
        when(() => fakeCallback.call(0, any()))
            .thenAnswer((_) async => successOf(successResponse));
        return cubit;
      },
      act: (PageableListCubit<PostEntity> cubit) {
        cubit.initialize();
      },
      expect: () => [
        PagableListLoading<PostEntity>(),
        isA<PagableListLoaded<PostEntity>>(),
      ],
    );

    blocTest<PageableListCubit<PostEntity>, PageableListState<PostEntity>>(
      'emits PagableListFailure when initialize fails',
      build: () {
        when(() => fakeCallback.call(0, any()))
            .thenAnswer((_) async => failureOf(failureResponse));
        return cubit;
      },
      act: (PageableListCubit<PostEntity> cubit) {
        cubit.initialize();
      },
      expect: () => [
        PagableListLoading<PostEntity>(),
        PagableListFailure<PostEntity>(error: failureResponse),
      ],
    );

    blocTest<PageableListCubit<PostEntity>, PageableListState<PostEntity>>(
      'emits PagableListLoading when reset is called',
      build: () {
        when(() => fakeCallback.call(0, any()))
            .thenAnswer((_) async => successOf(successResponse));
        return cubit;
      },
      act: (PageableListCubit<PostEntity> cubit) {
        cubit.reset();
      },
      expect: () => [
        PagableListLoading<PostEntity>(),
        isA<PagableListLoaded<PostEntity>>(),
      ],
    );
  });
}
