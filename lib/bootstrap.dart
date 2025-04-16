import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

import 'generated/codegen_loader.g.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    // await initDI();

    runApp(
      EasyLocalization(
        assetLoader: const CodegenLoader(),
        supportedLocales: const [Locale('en')],
        path: 'assets/localization',
        fallbackLocale: const Locale('en'),
        child: await builder(),
      ),
    );
  }, (error, stackTrace) => log(error.toString()));
}
