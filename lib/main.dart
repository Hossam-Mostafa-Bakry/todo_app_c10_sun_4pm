import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c10_sun_4pm/core/config/application_theme_manager.dart';
import 'package:todo_app_c10_sun_4pm/features/login/pages/login_view.dart';
import 'package:todo_app_c10_sun_4pm/features/register/pages/register_view.dart';
import 'package:todo_app_c10_sun_4pm/features/settings_provider.dart';
import 'package:todo_app_c10_sun_4pm/features/splash/pages/splash_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      title: 'TODO App',
      debugShowCheckedModeBanner: false,
      theme: ApplicationThemeManager.lightThemeData,
      darkTheme: ApplicationThemeManager.darkThemeData,
      themeMode: vm.currentTheme,
      initialRoute: SplashView.routeName,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        LoginView.routeName: (context) => LoginView(),
        RegisterView.routeName: (context) => RegisterView(),
      },
    );
  }
}
