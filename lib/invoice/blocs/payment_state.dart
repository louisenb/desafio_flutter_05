import 'package:desafio5/invoice/models/payment_option.dart';
import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentEmpty extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<PaymentOption>? paymentOptions;

  const PaymentLoaded({this.paymentOptions});

  @override
  List<Object> get props => [];
}

class PaymentError extends PaymentState {}