import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shopengo/core/presentation/screens/error_screen.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';
import 'package:shopengo/feature/home/presentation/home_screen.dart';
import 'package:shopengo/feature/store/presentation/store_screen.dart';

class RouterConfiguration {
  new() {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    _goRouter = GoRouter(
      navigatorKey: _rootNavigationKey,
      initialLocation: '/${HomeScreen.path}',
      redirect: (context, state) {
        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/${HomeScreen.path}',
          name: HomeScreen.path,
          pageBuilder:
              (context, state) =>
                  _getPage(key: state.pageKey, child: const HomeScreen()),
          routes: [
            _routeWithExtra<StoreModel>(
              path: StoreScreen.path,
              builder: (store) => StoreScreen(store: store),
            ),
          ],
        ),
      ],
    );
  }

  late final GoRouter _goRouter;

  GoRouter get router => _goRouter;

  final _rootNavigationKey = GlobalKey<NavigatorState>(
    debugLabel: 'makeBookingKey',
  );

  /// Route that requires `extra` of type [T]. Extra is lost on deep links and
  /// restoration, so we redirect to home when it's missing or of a wrong type.
  GoRoute _routeWithExtra<T>({
    required String path,
    required Widget Function(T extra) builder,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      name: path,
      redirect: (context, state) => state.extra is T ? null : '/${HomeScreen.path}',
      pageBuilder:
          (context, state) => _getPage(
            key: state.pageKey,
            child: switch (state.extra) {
              final T extra => builder(extra),
              _ => const ErrorScreen(),
            },
          ),
      routes: routes,
    );
  }

  Page<dynamic> _getPage({
    required ValueKey<dynamic> key,
    required Widget child,
  }) {
    if (Platform.isAndroid) {
      return NoTransitionPage(key: key, child: child);
    } else {
      return CupertinoPage(key: key, child: child);
    }
  }
}
