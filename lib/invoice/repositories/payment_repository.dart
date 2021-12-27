import 'dart:async';
import 'package:desafio5/invoice/models/payment_option.dart';
import 'package:desafio5/invoice/repositories/payment_api_client.dart';

class PaymentRepository {
  final PaymentApiClient paymentApiClient;

  PaymentRepository({required this.paymentApiClient});

  Future<List<PaymentOption>?> fetchPaymentOptions() async {
    return await paymentApiClient.fetchPaymentOptions();
  }
}