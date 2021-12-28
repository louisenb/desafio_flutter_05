import 'package:desafio5/invoice/models/payment_card.dart';
import 'package:desafio5/shared/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentReviewScreen extends StatelessWidget {
  static get route => 'PAYMENT_REVIEW_SCREEN';
  final AppNavigatorFactory appNavigator;

  PaymentReviewScreen({required this.appNavigator}) : super();

  Future<void> _showConfirmationAlert(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.failureToCharge),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(AppLocalizations.of(context)!.failureToChargeDetails)
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
    final args = (ModalRoute.of(context)!.settings.arguments as Map);
    final paymentCard = args["paymentCard"] as PaymentCard;

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.reviewPayment,
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Card(
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Wrap(
                        spacing: 20,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!
                                            .billOfTheMonth,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .operationFee,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .totalInvoice,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("R\$"),
                                    Text("R\$"),
                                    Text("R\$")
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)!
                                                .youWillPay,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      ])),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("R\$",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(40),
              padding: const EdgeInsets.all(20.0),
            ),
            onPressed: () => _showConfirmationAlert(context),
            child: Text(AppLocalizations.of(context)!.payInvoice),
          ),
        ));
  }
}
