import 'package:desafio5/shared/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentFormScreen extends StatefulWidget {
  static get route => 'PAYMENT_FORM_SCREEN';
  final AppNavigatorFactory appNavigator;

  const PaymentFormScreen({required this.appNavigator}) : super();

  @override
  _PaymentFormScreenState createState() {
    return _PaymentFormScreenState();
  }
}

class _PaymentFormScreenState extends State<PaymentFormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pagamento da fatura',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Número do Cartão'),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome do destino'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite aqui o destino';
                      }
                      return null;
                    },
                  ),
                  Text('Nome do títular do Cartão'),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'País'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite aqui o País';
                      }
                      return null;
                    },
                  ),
                  Text('Validade'),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Estado'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite aqui o Estado';
                      }
                      return null;
                    },
                  ),
                  Text('CVV'),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Cidade'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite aqui a Cidade';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            )
        ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Stack(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                  padding: const EdgeInsets.all(20.0),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                child: Text(AppLocalizations.of(context)!.continueProcess),
              ),
            ],
          )
      ),
    );
  }
}
