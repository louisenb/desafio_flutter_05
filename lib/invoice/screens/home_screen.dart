import 'package:desafio5/invoice/screens/payment_installments_screen.dart';
import 'package:desafio5/shared/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  static get route => 'HOME_SCREEN';
  final AppNavigatorFactory appNavigator;

  HomeScreen({required this.appNavigator}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Fatura Atual',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey)),
              Text('R\$ 6.000,20',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45)),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(40),
              padding: const EdgeInsets.all(20.0),
            ),
            onPressed: () {
              appNavigator.get(context).push(PaymentInstallmentsScreen.route);
            },
            child: Text(AppLocalizations.of(context)!.payInvoice),
          ),
        )
    );
  }
}
