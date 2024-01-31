import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shopengo/pages/bottom_navigation_container.dart';
import 'package:shopengo/pages/shopping_lists.dart';

class RouterService {
  late final GoRouter _goRouter;
  GoRouter get router => _goRouter;

  final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
  final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  RouterService() {
    _buildRouter();
  }

  void _buildRouter() {
    _goRouter = GoRouter(
      initialLocation: '/${HomePage.pageName}',
      navigatorKey: _rootNavigatorKey,
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => BottomNavigationContainer(child: child),
          routes: [
            GoRoute(
              path: '/${HomePage.pageName}',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
      ],
    );
  }
}
