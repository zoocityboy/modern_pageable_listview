import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logger.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../../logic/cubit/pageable/pageable_list_cubit.dart';
import '../widget/empty_placeholder_widget.dart';
import '../widget/loading_placeholder_widget.dart';
import '../widget/post_widget.dart';

/// Basic page with ListView
class PostPage extends StatelessWidget {
  /// Basic page with ListView
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageableListCubit<PostEntity>(
        callback: (page, limit) {
          return context.read<PostRepository>().list(page: page, limit: limit);
        },
      )..initialize(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar.medium(
                  title: const Text('Modern Pageable Listview'),
                ),
                BlocBuilder<PageableListCubit<PostEntity>,
                    PageableListState<PostEntity>>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    logger
                        .fine('PageableListCubit Build: ${state.runtimeType}');
                    return switch (state) {
                      PagableListInitial() ||
                      PagableListLoading() =>
                        LoadingPlaceholderWidget(
                          key: const Key('loading_placeholder'),
                          count: state.limit,
                        ),
                      PagableListFailure(error: final error) =>
                        Center(child: Text('Error $error')),
                      PagableListLoaded(
                        pages: final pages,
                        totalCount: final totalCount
                      ) =>
                        pages.isEmpty
                            ? const EmptyPlaceholderWidget(
                                key: Key('empty_placeholder'),
                              )
                            : SliverFixedExtentList.builder(
                                key: const Key('sliver_list'),
                                itemExtent: 90,
                                itemBuilder: (context, index) {
                                  return PostWidget(
                                    key: ValueKey<int>(index),
                                    index: index,
                                  );
                                },
                                itemCount: totalCount,
                                findChildIndexCallback: (value) {
                                  final index = value as ValueKey<int>;
                                  logger.fine('findChildIndexCallback: $index');
                                  return index.value;
                                },
                              )
                    };
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
