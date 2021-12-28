import 'package:desafio5/invoice/models/payment_card.dart';
import 'package:desafio5/invoice/screens/payment_review_screen.dart';
import 'package:desafio5/invoice/utils/card_formatter.dart';
import 'package:desafio5/invoice/utils/card_utils.dart';
import "package:desafio5/shared/app_navigation.dart";
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class PaymentFormScreen extends StatefulWidget {
  static get route => "PAYMENT_FORM_SCREEN";
  final AppNavigatorFactory appNavigator;

  PaymentFormScreen({required this.appNavigator}) : super();

  @override
  _PaymentFormScreenState createState() {
    return _PaymentFormScreenState(appNavigator: appNavigator);
  }
}

class _PaymentFormScreenState extends State<PaymentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final AppNavigatorFactory appNavigator;

  _PaymentFormScreenState({required this.appNavigator}) : super();

  @override
  Widget build(BuildContext context) {
    final paymentCard = new PaymentCard.empty();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.payment,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  runSpacing: 10,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.creditCardNumber,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.requiredField;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        new LengthLimitingTextInputFormatter(20),
                        new CardNumberInputFormatter()
                      ],
                      onSaved: (value) => paymentCard.number = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.creditCardHolder
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.requiredField;
                        }
                        return null;
                      },
                      onSaved: (value) => paymentCard.name = value!,
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        new LengthLimitingTextInputFormatter(4),
                        new CardMonthInputFormatter()
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.expirationDate
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.requiredField;
                        }
                        return CardUtils.validateDate(value, context);
                      },
                      onSaved: (value) => paymentCard.expirationDate = value!,
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        new LengthLimitingTextInputFormatter(4),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.cvv,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.requiredField;
                        }
                        return null;
                      },
                      onSaved: (value) => paymentCard.cvv = value!,
                    ),
                  ],
                )
              ],
            ),
          )),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Stack(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                  padding: EdgeInsets.all(20.0),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    appNavigator.get(context).push(PaymentReviewScreen.route, { "paymentCard": paymentCard });
                  }
                },
                child: Text(AppLocalizations.of(context)!.continueProcess),
              ),
            ],
          )),
    );
  }
}
