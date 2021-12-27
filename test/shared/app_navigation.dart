import 'package:desafio5/shared/app_navigation.dart';
import 'package:flutter/material.dart';

class TestAppNavigatorFactory extends AppNavigatorFactory {
  final AppNavigator mockAppNavigator;

  TestAppNavigatorFactory(this.mockAppNavigator);

  @override
  AppNavigator get(BuildContext context) => mockAppNavigator;
}