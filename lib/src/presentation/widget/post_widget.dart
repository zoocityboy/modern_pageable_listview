import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logger.dart';
import '../../domain/entities/post_entity.dart';
import '../../logic/cubit/page/page_cubit.dart';
import '../../logic/cubit/pageable/pageable_list_cubit.dart';
import 'post_error_tile.dart';
import 'post_loading_tile.dart';
import 'post_tile.dart';

/// Sample Post widget used as a ListTile
class PostWidget extends StatelessWidget {
  /// Sample Post widget used as a ListTile
  const PostWidget({required this.index, super.key});

  /// Position in the list
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key('post_widget_$index'),
      child: BlocBuilder<PageableListCubit<PostEntity>,
          PageableListState<PostEntity>>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is! PagableListLoaded<PostEntity>) {
            return const PostLoadingTile();
          }
          logger.info(
            'PostWidget[$index] PabeableListCubit Build: ${state.runtimeType}',
          );
          final page = index ~/ state.limit;
          final indexOnPage = index % state.limit;
          return BlocProvider.value(
            value: state.pages[page]!..fetch(),
            child: Builder(
              builder: (context) {
                return BlocBuilder<PageCubit<PostEntity>,
                    PageState<PostEntity>>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    logger.info(
                      '- PostWidget[$index] PageCubit Build: ${state.runtimeType}',
                    );
                    return switch (state) {
                      PageInitial() || PageLoading() => PostLoadingTile(
                          key: Key('post_widget_loading_${page}_$indexOnPage'),
                        ),
                      PageFailure(error: final error) =>
                        PostErrorTile(error: error),
                      PageLoaded(items: final items) => PostTile(
                          key: ValueKey(items[indexOnPage].id),
                          item: items[indexOnPage],
                          page: page,
                          indexOnPage: indexOnPage,
                        )
                    };
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
