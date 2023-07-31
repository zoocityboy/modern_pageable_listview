// ignore_for_file: public_member_api_docs

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'src/core/observer.dart';
import 'src/domain/repositories/post_repository.dart';
import 'src/presentation/pages/test_page.dart';

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

final baseLight = ThemeData.light(useMaterial3: true);
final baseDark = ThemeData.dark(useMaterial3: true);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<PostRepository>(
      create: (context) => PostRepository(10000),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            home: const TestPage(),
            theme: baseLight.copyWith(
              cardTheme: CardTheme(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: baseLight.colorScheme.outlineVariant,
                  ),
                ),
              ),
            ),
            darkTheme: baseDark.copyWith(
              cardTheme: CardTheme(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: baseDark.colorScheme.outlineVariant,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
