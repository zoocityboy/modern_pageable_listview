import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/pageable.dart';
import '../../../domain/typedef/loadcallback.dart';
import '../page/page_cubit.dart';

part 'pageable_list_state.dart';

/// Basic orechstrator Cubit for loading pages from API
class PageableListCubit<T extends Object> extends Cubit<PageableListState<T>> {
  /// Creates a new instance of [PageableListCubit] with the specified [limit] and default value of 10.
  PageableListCubit({required this.apiRequest, this.limit = 10})
      : super(PageableListInitial<T>(limit: limit));

  /// Limit defines pageSize
  final int limit;

  /// The callback function for loading data from API
  final LoadCallback<T> apiRequest;

  /// Initialize the PageableListCubit and load first page
  void initialize() {
    emit(PageableListLoading<T>());
    apiRequest(0, limit).then(
      (result) {
        emit(
          result.fold(
            (success) => PageableListLoaded<T>(
              pages: success.convert(limit, apiRequest),
              totalCount: success.totalCount,
            ),
            (failure) => PageableListFailure<T>(error: failure),
          ),
        );
      },
    ).catchError((Object error) {
      emit(PageableListFailure<T>(error: error));
    });
  }

  /// Clear all data and re-initialize PageableListCubit
  Future<void> reset() async {
    emit(PageableListLoading<T>());
    initialize();
  }
}
