import 'package:flutter/material.dart';


enum AppRoute {
  splash,
  login
}

extension AppRouteName on AppRoute {
  String get name => const {
    AppRoute.splash: '/',
    AppRoute.login: '/login'
  }[this];
}

Widget Function(BuildContext) f(Widget page) {
  return (context) => page;
}