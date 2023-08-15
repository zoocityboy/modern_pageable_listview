// ignore_for_file: public_member_api_docs

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/contact_entity.dart';
import '../../domain/repositories/contact_repository.dart';
import '../../logic/cubit/page/page_cubit.dart';
import '../../logic/cubit/pageable/pageable_list_cubit.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PageableListCubit<ContactEntity>(
          apiRequest: (page, limit) =>
              context.read<ContactRepository>().list(page: page, limit: limit),
        )..initialize(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              title: const Text('Modern Pageable Listview'),
            ),
            BlocBuilder<PageableListCubit<ContactEntity>,
                PageableListState<ContactEntity>>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return switch (state) {
                  PageableListInitial() ||
                  PageableListLoading() =>
                    SliverList.separated(
                      key: const Key('loading_listview'),
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        return const ListTileSkeleton();
                      },
                      itemCount: state.limit,
                    ),
                  PageableListFailure(error: final _) =>
                    const SliverToBoxAdapter(),
                  PageableListLoaded(totalCount: final totalCount) =>
                    SliverList.separated(
                      key: const Key('loaded_listview'),
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        return ContactListItem(
                          key: ValueKey<int>(index),
                          index: index,
                        );
                      },
                      itemCount: totalCount,
                      findChildIndexCallback: (key) {
                        final typedKey = key as ValueKey<int>;
                        return typedKey.value;
                      },
                    )
                };
              },
            )
          ],
        ),
      ),
    );
  }
}

class ContactListItem extends StatelessWidget {
  const ContactListItem({required this.index, super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageableListCubit<ContactEntity>,
        PageableListState<ContactEntity>>(
      key: ValueKey<String>('list_item_blocBuilder_$index'),
      buildWhen: (p, c) => p != c,
      builder: (context, state) {
        if (state is! PageableListLoaded<ContactEntity>) {
          return const ListTileSkeleton();
        }
        final page = index ~/ state.limit;
        final indexOnPage = index % state.limit;
        return BlocProvider.value(
          key: ValueKey<String>(
            'list_item_content_${page}_${indexOnPage}_blocProvider',
          ),
          value: state.pages[page]!..fetch(),
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
    return BlocBuilder<PageCubit<ContactEntity>, PageState<ContactEntity>>(
      key: ValueKey<String>(
        'list_item_content_${page}_${indexOnPage}_blocBuilder',
      ),
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is! PageLoaded<ContactEntity>) {
          return const ListTileSkeleton();
        }
        final currentState = state;
        final item = currentState.items[indexOnPage];
        return ListTile(
          key: ValueKey<int>(index),
          leading: CachedNetworkImage(
            imageUrl: item.avatarUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondaryContainer,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            errorWidget: (context, url, error) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            width: 48,
            height: 48,
          ),
          title: Text(
            item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            item.email,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          enabled: false,
          trailing: const Checkbox.adaptive(
            value: false,
            onChanged: null,
          ),
        );
      },
    );
  }
}

class ListTileSkeleton extends StatelessWidget {
  const ListTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.outline;
    return ListTile(
      leading: SizedBox.square(
        dimension: 48,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: color,
        ),
        width: MediaQuery.of(context).size.width * .7,
        height: 16,
      ),
      subtitle: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: color,
        ),
        width: MediaQuery.of(context).size.width * .6,
        height: 16,
      ),
    );
  }
}
