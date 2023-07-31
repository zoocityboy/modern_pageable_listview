// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'test_cubit.dart';

sealed class TestState extends Equatable {
  const TestState({this.limit = 10});
  final int limit;

  @override
  List<Object> get props => [
        limit,
      ];
}

class TestInitial extends TestState {}

class TestLoaded extends TestState {
  const TestLoaded({
    required this.items,
    required this.totalCount,
  });

  final Map<int, PageCubit<String>> items;
  final int totalCount;

  @override
  List<Object> get props => [items, limit, totalCount];
}
