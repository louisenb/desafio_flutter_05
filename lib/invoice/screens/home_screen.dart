import 'package:desafio5/invoice/screens/payment_installments_screen.dart';
import 'package:desafio5/shared/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  static get route => 'HOME_SCREEN';
  final AppNavigatorFactory appNavigator;
  var totalInvoice = 3025.49;

  HomeScreen({required this.appNavigator}) : super();

  Future<void> _showMenuAlert(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.attention),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(AppLocalizations.of(context)!.functionalityNotAccessible)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            new IconButton(
              icon: new Icon (
                  Icons.account_circle_outlined,
                  color: Colors.black
              ), onPressed: () => _showMenuAlert(context)
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.currentInvoice,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey)),
              Text('R\$ $totalInvoice',
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
            onPressed: () => appNavigator.get(context).push(PaymentInstallmentsScreen.route, { "totalInvoice": totalInvoice }),
            child: Text(AppLocalizations.of(context)!.payInvoice),
          ),
        )
    );
  }
}
