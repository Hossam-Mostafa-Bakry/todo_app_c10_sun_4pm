import 'package:flutter/material.dart';
import 'package:todo_app_c10_sun_4pm/main.dart';

class Constants {
  static var theme = Theme.of(navigatorKey.currentState!.context);
  static var mediaQuery =
      MediaQuery.of(navigatorKey.currentState!.context).size;
}
