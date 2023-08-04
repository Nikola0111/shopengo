import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shopengo/blocs/app_bloc/app_bloc.dart';
import 'package:shopengo/blocs/app_bloc/app_event.dart';
import 'package:shopengo/blocs/app_bloc/app_state.dart';
import 'package:shopengo/services/router_service.dart';

void main() {
  runApp(const Shopengo());
}

class Shopengo extends StatelessWidget {
  const Shopengo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc()..add(LoadApp()),
      child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
        if (state is AppInitial) {
          // show splash screen here if needed
          return const SizedBox.shrink();
        }

        if (state is AppLoaded) {
          // we can get theme and other app settings from app bloc
          final router = KiwiContainer().resolve<RouterService>().router;
          return EasyLocalization(
            supportedLocales: const [Locale('en'), Locale('en')],
            fallbackLocale: const Locale('en'),
            path: 'assets/localization',
            child: Builder(
              builder: (context) {
                // theme is set in RouterService
                return MaterialApp.router(
                  title: 'Shopengo',
                  // theme: appProvider.themeData,
                  routerConfig: router,
                  debugShowCheckedModeBanner: false,
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      }),
    );
  }
}
