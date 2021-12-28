import 'package:desafio5/invoice/models/payment_option.dart';
import 'package:equatable/equatable.dart';

abstract class PaymentOptionsEvent extends Equatable {
  const PaymentOptionsEvent();
}

class FetchPaymentOptions extends PaymentOptionsEvent {
  const FetchPaymentOptions();

  @override
  List<Object> get props => [];
}

abstract class PaymentInvoiceEvent {
  const PaymentInvoiceEvent();
}

class SavePaymentInvoice extends PaymentInvoiceEvent {
  final PaymentOption paymentOption;

  SavePaymentInvoice(this.paymentOption);
}