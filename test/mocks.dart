import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modern_pageable_listview/src/core/theme.dart';
import 'package:modern_pageable_listview/src/domain/entities/pageable.dart';
import 'package:modern_pageable_listview/src/domain/repositories/contact_repository.dart';
import 'package:modern_pageable_listview/src/domain/repositories/post_repository.dart';
import 'package:modern_pageable_listview/src/logic/cubit/page/page_cubit.dart';
import 'package:modern_pageable_listview/src/logic/cubit/pageable/pageable_list_cubit.dart';
import 'package:result_dart/result_dart.dart';

class MockLoadCallback<T extends Object> extends Mock {
  Future<Result<Pageable<T>, Exception>> call(int page, int limit);
}

class MockPageableListCubit<T extends Object> extends Mock
    implements PageableListCubit<T> {}

class MockPageCubit<T extends Object> extends Mock implements PageCubit<T> {}

class MockPostRepository extends Mock implements IPostRepository {}

class MockException implements Exception {}

extension WidgetTesterX on WidgetTester {
  Future<void> pumpPage(
    Widget widget,
  ) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<PostRepository>(
            create: (context) => PostRepository(10000),
          ),
          RepositoryProvider(
            create: (context) => ContactRepository(10000),
          ),
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              home: Scaffold(
                body: widget,
              ),
            );
          },
        ),
      ),
    );
  }
}
