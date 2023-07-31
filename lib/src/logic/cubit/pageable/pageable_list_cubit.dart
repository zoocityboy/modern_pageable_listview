import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/entities/pageable.dart';
import '../page/page_cubit.dart';

part 'pageable_list_state.dart';
part 'pageable_list_types.dart';

/// Basic orechstrator Cubit for loading pages from API
class PageableListCubit<T extends Object> extends Cubit<PageableListState<T>> {
  /// Creates a new instance of [PageableListCubit] with the specified [limit] and default value of 10.
  PageableListCubit({required this.callback, this.limit = 10})
      : super(PagableListInitial<T>(limit: limit));

  /// Limit defines pageSize
  final int limit;

  /// The callback function for loading data from API
  final LoadCallback<T> callback;

  /// Initialize the PageableListCubit and load first page
  void initialize() {
    emit(PagableListLoading<T>());
    callback(0, limit).then(
      (result) {
        emit(
          result.fold(
            (success) => PagableListLoaded<T>(
              pages: success.convert(limit, callback),
              totalCount: success.totalCount,
            ),
            (failure) => PagableListFailure<T>(error: failure),
          ),
        );
      },
    ).catchError((Object error) {
      emit(PagableListFailure<T>(error: error));
    });
  }

  /// Clear all data and re-initialize PageableListCubit
  Future<void> reset() async {
    emit(PagableListLoading<T>());
    initialize();
  }
}
