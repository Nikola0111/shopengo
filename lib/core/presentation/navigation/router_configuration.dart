import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shopengo/feature/home/presentation/home_screen.dart';
import 'package:shopengo/feature/shopping_list/presentation/shopping_list_screen.dart';

class RouterConfiguration {
  RouterConfiguration() {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    _goRouter = GoRouter(
      navigatorKey: _rootNavigationKey,
      initialLocation: '/${HomeScreen.path}',
      redirect: (context, state) => null,
      routes: <RouteBase>[
        GoRoute(
          path: '/${HomeScreen.path}',
          name: HomeScreen.path,
          pageBuilder: (context, state) => _getPage(
            key: state.pageKey,
            child: const HomeScreen(),
          ),
          routes: [
            GoRoute(
              path: ShoppingListScreen.path,
              name: ShoppingListScreen.path,
              pageBuilder: (context, state) {
                final storeIDString = state.pathParameters['storeID']!;
                return _getPage(
                  key: state.pageKey,
                  child: ShoppingListScreen(storeID: int.parse(storeIDString)),
                );
              },
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
