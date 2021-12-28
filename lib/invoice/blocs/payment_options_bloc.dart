import 'package:desafio5/invoice/blocs/payment_options_event.dart';
import 'package:desafio5/invoice/blocs/payment_options_state.dart';
import 'package:desafio5/invoice/models/payment_option.dart';
import 'package:desafio5/invoice/repositories/payment_repository.dart';
import 'package:bloc/bloc.dart';

class PaymentOptionsBloc extends Bloc<PaymentOptionsEvent, PaymentOptionsState> {
  final PaymentRepository repository;

  PaymentOptionsBloc({required this.repository});

  @override
  PaymentOptionsState get initialState => PaymentOptionsEmpty();

  @override
  Stream<PaymentOptionsState> mapEventToState(PaymentOptionsEvent event) async* {
    if (event is FetchPaymentOptions) {
      yield PaymentOptionsLoading();

      try {
        final List<PaymentOption>? paymentOptions = await repository.fetchPaymentOptions();
        yield PaymentOptionsLoaded(paymentOptions: paymentOptions);
      } catch (_) {
        yield PaymentOptionsError();
      }
    }
  }
}