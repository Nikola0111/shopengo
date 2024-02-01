import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shopengo/core/services/environment_service.dart';
import 'package:shopengo/core/services/router_service.dart';
import 'package:shopengo/kiwi_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  injectServices();
  KiwiContainer().resolve<EnvironmentService>().init();

  runApp(const Shopengo());
}

class Shopengo extends StatelessWidget {
  const Shopengo({super.key});

  @override
  Widget build(BuildContext context) {
    final router = KiwiContainer().resolve<RouterService>().router;
    return EasyLocalization(
      supportedLocales: const [Locale('sr'), Locale('en')],
      fallbackLocale: const Locale('en'),
      path: 'assets/localization',
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'Shopengo',
            routerConfig: router,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
