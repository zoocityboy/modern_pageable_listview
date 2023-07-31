// ignore_for_file: strict_raw_type, avoid_dynamic_calls, public_member_api_docs

import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubit/page/page_cubit.dart';
import 'logger.dart';

class ZooBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    if (bloc is PageCubit) {
      blocLogger.info(
        'onChange [${bloc.runtimeType}][${bloc.page}] ${change.currentState.runtimeType} -> ${change.nextState.runtimeType}',
      );
    } else {
      blocLogger.info(
        'onChange [${bloc.runtimeType}] ${change.currentState.runtimeType} -> ${change.nextState.runtimeType}',
      );
    }
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (bloc is PageCubit) {
      blocLogger.severe(
        'onChange [${bloc.runtimeType}] ${bloc.page} $error',
        error,
        stackTrace,
      );
    } else {
      blocLogger.severe(
        'onChange [${bloc.runtimeType}] $error',
        error,
        stackTrace,
      );
    }

    super.onError(bloc, error, stackTrace);
  }
}
