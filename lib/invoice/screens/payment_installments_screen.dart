import 'package:desafio5/invoice/blocs/payment_bloc.dart';
import 'package:desafio5/invoice/blocs/payment_event.dart';
import 'package:desafio5/invoice/blocs/payment_state.dart';
import 'package:desafio5/invoice/models/payment_option.dart';
import 'package:desafio5/invoice/screens/payment_form_screen.dart';
import 'package:desafio5/shared/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentInstallmentsScreen extends StatefulWidget {
  static get route => 'PAYMENT_INSTALLMENTS_SCREEN';
  final AppNavigatorFactory appNavigator;

  PaymentInstallmentsScreen({required this.appNavigator}) : super();

  @override
  createState() => _PaymentInstallmentsScreenState(appNavigator: appNavigator);
}

class _PaymentInstallmentsScreenState extends State<PaymentInstallmentsScreen> {
  final AppNavigatorFactory appNavigator;
  var _numberOfInstallments = 1;
  var _convenience = 0.0;

  _PaymentInstallmentsScreenState({required this.appNavigator}) : super();

  _recalculateFee(int numberOfInstallments, double convenience) {
    setState(() {
      _numberOfInstallments = numberOfInstallments;
      _convenience = convenience;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)!.settings.arguments as Map);
    final totalInvoice = args["totalInvoice"];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.selectAnInstallment,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentEmpty) {
            BlocProvider.of<PaymentBloc>(context).add(FetchPaymentOptions());
          }

          if (state is PaymentError) {
            return Center(
              child: Text('failed to payment options'),
            );
          }

          if (state is PaymentLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        shrinkWrap: true,
                        itemCount: state.paymentOptions!.length,
                        itemBuilder: (context, index) {
                          PaymentOption option =
                              state.paymentOptions!.elementAt(index);

                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: Card(
                                  // shadowColor: Colors.red,
                                  child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                child: ListTile(
                                  leading: Radio(
                                      value: option.number,
                                      activeColor: Colors.blue,
                                      groupValue: _numberOfInstallments,
                                      onChanged: (index) => _recalculateFee(
                                          option.number, option.convenience)),
                                  title: Text(
                                      '${option.number} x ${option.value}'),
                                  trailing: Text(
                                    'R\$ ${option.total}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                            ),
                          );
                        })),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
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
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("R\$ $totalInvoice"),
                                  Text("R\$ $_convenience"),
                                ],
                              ),
                            )
                          ],
                        ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
                    child: Stack(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(40),
                            padding: EdgeInsets.all(20.0),
                          ),
                          onPressed: () => appNavigator.get(context).push(PaymentFormScreen.route, {}),
                          child: Text(
                              AppLocalizations.of(context)!.continueProcess),
                        ),
                      ],
                    )),
              ],
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
