import 'package:desafio5/invoice/blocs/payment_bloc.dart';
import 'package:desafio5/invoice/blocs/payment_event.dart';
import 'package:desafio5/invoice/blocs/payment_state.dart';
import 'package:desafio5/invoice/models/payment_option.dart';
import 'package:desafio5/shared/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentInstallmentsScreen extends StatelessWidget {
  static get route => 'PAYMENT_INSTALLMENTS_SCREEN';
  final AppNavigatorFactory appNavigator;

  PaymentInstallmentsScreen({required this.appNavigator}) : super();

  @override
  Widget build(BuildContext context) {
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
            return ListView.builder(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                shrinkWrap: true,
                itemCount: state.paymentOptions!.length,
                itemBuilder: (context, index) {
                  PaymentOption option = state.paymentOptions!.elementAt(index);

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
                              groupValue: 1,
                              onChanged: (index) {}),
                          title: Text('${option.number} x ${option.value}'),
                          trailing: Text(
                            'R\$ ${option.total}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                    ),
                  );
                }
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
          child: Stack(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                  padding: const EdgeInsets.all(20.0),
                ),
                onPressed: () {

                },
                child: Text(AppLocalizations.of(context)!.continueProcess),
              ),
            ],
          )),
    );
  }
}
