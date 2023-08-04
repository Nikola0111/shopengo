import 'package:shopengo/mixins/logger_mixin.dart';

enum Environment { dev, test, prod }

class EnvironmentService with LoggerMixin {
  static late Environment environment;

  @override
  String get className => 'EnvironmentService';
}
