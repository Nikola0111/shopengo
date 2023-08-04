import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

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
      navigatorKey: _rootNavigatorKey,
      // initialLocation: '/${LoginPage.pageName}',
      redirect: (context, state) {
        return null;
      },
      routes: [
        ShellRoute(
          routes: [],
        ),
      ],
    );
  }
}
