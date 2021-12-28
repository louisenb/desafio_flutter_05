import 'package:flutter/material.dart';

class AppNavigatorFactory {
  AppNavigator get(BuildContext context) =>
      AppNavigator._forNavigator(Navigator.of(context));
}

class AppNavigator {
  NavigatorState _flutterNavigator;
  AppNavigator._forNavigator(this._flutterNavigator);

  void push(String route, Object? params) {
    _flutterNavigator.pushNamed(route, arguments: params);
  }
}