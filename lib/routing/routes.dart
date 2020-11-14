import 'package:flutter/material.dart';


enum AppRoute {
  home,
  login
}

extension AppRouteName on AppRoute {
  String get name => const {
    AppRoute.home: '/',
    AppRoute.login: '/login'
  }[this];
}

Widget Function(BuildContext) f(Widget page) {
  return (context) => page;
}