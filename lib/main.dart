// ignore_for_file: public_member_api_docs

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'src/core/observer.dart';
import 'src/core/theme.dart';
import 'src/domain/repositories/contact_repository.dart';
import 'src/domain/repositories/post_repository.dart';
import 'src/presentation/pages/contact_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint(
      record.toString(),
      // level: record.level.value,
      // time: record.time,
      // stackTrace: record.stackTrace,
      // error: record.object,
    );
  });
  Bloc.observer = ZooBlocObserver();
  Bloc.transformer = sequential();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
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
            navigatorKey: navigatorKey,
            home: const TestPage(),
            theme: lightTheme,
            darkTheme: darkTheme,
          );
        },
      ),
    );
  }
}
