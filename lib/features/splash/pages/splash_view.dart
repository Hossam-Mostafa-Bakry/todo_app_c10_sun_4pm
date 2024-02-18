import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c10_sun_4pm/features/login/pages/login_view.dart';
import 'package:todo_app_c10_sun_4pm/features/settings_provider.dart';

class SplashView extends StatefulWidget {
  static const String routeName = "/";

  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(
          context,
          LoginView.routeName,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Image.asset(
        vm.isDark()
            ? "assets/images/splash_dark_background.png"
            : "assets/images/splash_background.png",
        height: mediaQuery.height,
        width: mediaQuery.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
