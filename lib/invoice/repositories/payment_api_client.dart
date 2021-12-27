import 'dart:convert';
import 'package:desafio5/invoice/models/payment_option.dart';
import 'package:http/http.dart' as http;

class PaymentApiClient {
  final _baseUrl = 'https://dreamy-allen-2e1b47.netlify.app';
  final http.Client httpClient;

  PaymentApiClient({required this.httpClient});

  Future<List<PaymentOption>>? fetchPaymentOptions() async {
    final url = Uri.parse('$_baseUrl/payment-options.json');
    final http.Response response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('Something went wrong.');
    }

    final Iterable l = json.decode(response.body)['options']['installments'];

    return List<PaymentOption>.from(
        l.map((model) => PaymentOption.fromJson(model))).toList();
  }
}
