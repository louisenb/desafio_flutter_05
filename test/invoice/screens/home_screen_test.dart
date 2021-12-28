import 'package:desafio5/invoice/screens/home_screen.dart';
import 'package:desafio5/invoice/screens/payment_installments_screen.dart';
import 'package:desafio5/shared/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../shared/app_navigation.dart';

class MockAppNavigator extends Mock implements AppNavigator {}

void main() {
  final appNavigator = MockAppNavigator();

  setUp(() {
    reset(appNavigator);
  });

  testWidgets('Button is present and triggers navigation after tapped', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen(appNavigator: TestAppNavigatorFactory(appNavigator))));

      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));

      verify(appNavigator.push(PaymentInstallmentsScreen.route, {}));
    });
}