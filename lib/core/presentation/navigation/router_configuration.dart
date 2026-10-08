import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
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
            GoRoute(
              path: StoreScreen.path,
              name: StoreScreen.path,
              pageBuilder:
                  (context, state) => _getPage(
                    key: state.pageKey,
                    child: StoreScreen(store: state.extra! as StoreModel),
                  ),
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
