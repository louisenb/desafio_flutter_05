import 'package:desafio5/invoice/screens/home_screen.dart';
import 'package:desafio5/invoice/screens/payment_form_screen.dart';
import 'package:desafio5/shared/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'invoice/blocs/payment_bloc.dart';
import 'invoice/repositories/payment_api_client.dart';
import 'invoice/repositories/payment_repository.dart';
import 'invoice/screens/payment_installments_screen.dart';
import 'invoice/screens/payment_review_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  final AppNavigatorFactory appNavigator = new AppNavigatorFactory();

  runApp(App(
    repository: repository,
    appNavigator: appNavigator
  ));
}

class App extends StatelessWidget {
  final PaymentRepository repository;
  final AppNavigatorFactory appNavigator;

  App({required this.repository, required this.appNavigator}) : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        body: BlocProvider(
          create: (context) => PaymentBloc(repository: repository),
          child: HomeScreen(appNavigator: appNavigator),
        ),
      ),
      routes: {
        PaymentInstallmentsScreen.route: (_) => BlocProvider(
          create: (context) => PaymentBloc(repository: repository),
          child: PaymentInstallmentsScreen(appNavigator: appNavigator),
        ),
        PaymentFormScreen.route: (_) => PaymentFormScreen(appNavigator: appNavigator),
        PaymentReviewScreen.route: (_) => PaymentReviewScreen(appNavigator: appNavigator),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}