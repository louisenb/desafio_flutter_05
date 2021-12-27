import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}

class FetchPaymentOptions extends PaymentEvent {
  const FetchPaymentOptions();

  @override
  List<Object> get props => [];
}