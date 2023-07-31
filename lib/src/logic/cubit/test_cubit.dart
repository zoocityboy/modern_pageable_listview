// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:result_dart/functions.dart';

import '../../domain/entities/pageable.dart';
import 'page/page_cubit.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestInitial());

  void load() {
    Future<void>.delayed(250.ms, () {
      final faker = Faker();
      final map = <int, PageCubit<String>>{};
      const pages = 1000;
      final totalCount = state.limit * pages;
      for (var index = 0; index < pages; index++) {
        map[index] = PageCubit<String>(
          callback: (page, limit) async {
            await Future<void>.delayed(250.ms);
            return successOf(
              Pageable<String>(
                data: List.generate(
                  state.limit,
                  (index) {
                    return faker.lorem.sentence();
                  },
                ),
                page: page,
                pageSize: state.limit,
                totalCount: totalCount,
              ),
            );
          },
          page: index,
          limit: state.limit,
        );
      }

      emit(TestLoaded(items: map, totalCount: totalCount));
    });
  }
}
