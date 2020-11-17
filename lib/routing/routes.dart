import 'package:flutter/material.dart';


enum AppRoute {
  home,
  login,
  dashboard,
  add,
  account,
  edit,
  quantity
}

extension AppRouteName on AppRoute {
  String get name => const {
    AppRoute.home: '/',
    AppRoute.login: '/login',
    AppRoute.dashboard: '/dashboard',
    AppRoute.add: '/add',
    AppRoute.account: '/account',
    AppRoute.edit: '/edit',
    AppRoute.quantity: '/quantity'
  }[this];
}

Widget Function(BuildContext) f(Widget page) {
  return (context) => page;
}