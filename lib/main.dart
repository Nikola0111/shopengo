import 'package:go_router/go_router.dart';
import 'package:shopengo/app.dart';
import 'package:shopengo/bootstrap.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  bootstrap(() => App());
}
