// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logger.dart';
import '../../logic/cubit/page/page_cubit.dart';
import '../../logic/cubit/test_cubit.dart';

class VisibilityCubit extends Cubit<bool> {
  VisibilityCubit() : super(true);
  void toggle() {
    emit(!state);
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisibilityCubit(),
      child: BlocBuilder<VisibilityCubit, bool>(
        builder: (context, state) {
          return Scaffold(
            body: BlocProvider(
              create: (context) => TestCubit()..load(),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar.medium(
                    title: const Text('Modern Pageable Listview'),
                  ),
                  BlocBuilder<TestCubit, TestState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      return switch (state) {
                        TestInitial() => SliverFixedExtentList.builder(
                            key: const Key('loading_listview'),
                            itemExtent: 64,
                            itemBuilder: (context, index) {
                              return const ListTile(
                                enabled: false,
                              );
                            },
                            itemCount: state.limit,
                          ),
                        TestLoaded(totalCount: final totalCount) =>
                          SliverFixedExtentList.builder(
                            key: const Key('loaded_listview'),
                            itemExtent: 64,
                            itemBuilder: (context, index) {
                              logger.info('rebuild index: $totalCount/ $index');
                              return ListItem(
                                key: ValueKey<int>(index),
                                index: index,
                              );
                            },
                            itemCount: totalCount,
                            findChildIndexCallback: (key) {
                              final typedKey = key as ValueKey<int>;
                              logger.info(
                                'findChildIndexCallback: ${typedKey.value} / ${typedKey.value}',
                              );
                              return typedKey.value;
                            },
                          )
                      };
                    },
                  )
                ],
              ),
            ),
            bottomNavigationBar: SizedBox(
              child: IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  context.read<VisibilityCubit>().toggle();
                },
              ),
            ),
            floatingActionButton: state
                ? FloatingActionButton.large(
                    onPressed: () {},
                    child: const Icon(Icons.link_off_outlined),
                  )
                : null,
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          );
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({required this.index, super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestCubit, TestState>(
      key: ValueKey<String>('list_item_blocBuilder_$index'),
      buildWhen: (p, c) => p != c && c is TestLoaded,
      builder: (context, state) {
        // logger.fine(
        //   'TestCubit Build: ${state.runtimeType}',
        // );
        if (state is! TestLoaded) return const SizedBox.shrink();
        final page = index ~/ state.limit;
        final indexOnPage = index % state.limit;
        return BlocProvider.value(
          key: ValueKey<String>(
            'list_item_content_${page}_${indexOnPage}_blocProvider',
          ),
          value: state.items[page]!..fetch(),
          child: ListItemContent(
            key: ValueKey<String>('list_item_content_${page}_$indexOnPage'),
            index: index,
            page: page,
            indexOnPage: indexOnPage,
          ),
        );
      },
    );
  }
}

class ListItemContent extends StatelessWidget {
  const ListItemContent({
    required this.index,
    required this.page,
    required this.indexOnPage,
    super.key,
  });
  final int index;
  final int page;
  final int indexOnPage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit<String>, PageState<String>>(
      key: ValueKey<String>(
        'list_item_content_${page}_${indexOnPage}_blocBuilder',
      ),
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        logger.fine(
          'PageCubit index: $index | $page/ $indexOnPage Build: ${state.runtimeType}',
        );
        if (state is! PageLoaded) return const SizedBox.shrink();
        final currentState = state as PageLoaded<String>;
        final item = currentState.items[indexOnPage];
        return ListTile(
          key: ValueKey<int>(index),
          title: Text(
            item,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          enabled: false,
        );
      },
    );
  }
}
