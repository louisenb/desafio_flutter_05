import 'package:desafio5/invoice/models/payment_option.dart';
import 'package:equatable/equatable.dart';

abstract class PaymentOptionsState extends Equatable {
  const PaymentOptionsState();

  @override
  List<Object> get props => [];
}

class PaymentOptionsEmpty extends PaymentOptionsState {}

class PaymentOptionsLoading extends PaymentOptionsState {}

class PaymentOptionsLoaded extends PaymentOptionsState {
  final List<PaymentOption>? paymentOptions;

  const PaymentOptionsLoaded({this.paymentOptions});

  @override
  List<Object> get props => [];
}

class PaymentOptionsError extends PaymentOptionsState {}