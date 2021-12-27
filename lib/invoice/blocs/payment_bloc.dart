import 'package:desafio5/invoice/blocs/payment_event.dart';
import 'package:desafio5/invoice/blocs/payment_state.dart';
import 'package:desafio5/invoice/models/payment_option.dart';
import 'package:desafio5/invoice/repositories/payment_repository.dart';
import 'package:bloc/bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository repository;

  PaymentBloc({required this.repository});

  @override
  PaymentState get initialState => PaymentEmpty();

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    if (event is FetchPaymentOptions) {
      yield PaymentLoading();

      try {
        final List<PaymentOption>? paymentOptions = await repository.fetchPaymentOptions();
        yield PaymentLoaded(paymentOptions: paymentOptions);
      } catch (_) {
        yield PaymentError();
      }
    }
  }
}