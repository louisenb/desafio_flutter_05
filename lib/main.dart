import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'invoice/blocs/payment_bloc.dart';
import 'invoice/repositories/payment_api_client.dart';
import 'invoice/repositories/payment_repository.dart';
import 'invoice/screens/payment_installments_screen.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final PaymentRepository repository = PaymentRepository(
    paymentApiClient: PaymentApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(App(
    repository: repository,
  ));
}

class App extends StatelessWidget {
  final PaymentRepository repository;

  App({required this.repository}) : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        body: BlocProvider(
          create: (context) => PaymentBloc(repository: repository),
          child: PaymentInstallmentsScreen(),
        ),
      )
    );
  }
}