import 'dart:convert';

import 'package:desafio5/invoice/models/payment_option.dart';
import 'package:desafio5/invoice/repositories/payment_api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockPaymentApiClient extends Mock implements PaymentApiClient {
  late final PaymentApiClient _real;

  MockPaymentApiClient(http.Client httpClient) {
    _real = PaymentApiClient(httpClient: httpClient);
    when(fetchPaymentOptions()).thenAnswer((_) => _real.fetchPaymentOptions());
  }
}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('fetchPaymentOptions', () {
    final mockHttpClient = MockHttpClient();
    final mockPaymentApiClient = MockPaymentApiClient(mockHttpClient);

    test('return PaymentOptions if http call successfully', () async {
      final mockPaymentOptionsString = '''
        {
          "options": {
            "convinienceFee": 0.05,
            "convinienceFeeAmount": 227.23,
            "installments": [
              {
                "number": 1,
                "value": 4775,
                "total": 4775,
                "fee": 0,
                "convinience": 230.45
              },
              {
                "number": 2,
                "value": 2447.5,
                "total": 4895,
                "fee": 0.025,
                "convinience": 350.45
              },
              {
                "number": 3,
                "value": 1631.67,
                "total": 4895,
                "fee": 0.025,
                "convinience": 350.45
              },
              {
                "number": 4,
                "value": 1223.75,
                "total": 4895,
                "fee": 0.025,
                "convinience": 350.45
              },
              {
                "number": 5,
                "value": 995,
                "total": 4975,
                "fee": 0.04,
                "convinience": 430.45
              },
              {
                "number": 6,
                "value": 829.17,
                "total": 4975,
                "fee": 0.04,
                "convinience": 430.45
              },
              {
                "number": 7,
                "value": 710.71,
                "total": 4975,
                "fee": 0.04,
                "convinience": 430.45
              },
              {
                "number": 8,
                "value": 631.25,
                "total": 5050,
                "fee": 0.055,
                "convinience": 505.45
              },
              {
                "number": 9,
                "value": 561.11,
                "total": 5050,
                "fee": 0.055,
                "convinience": 505.45
              },
              {
                "number": 10,
                "value": 505,
                "total": 5050,
                "fee": 0.055,
                "convinience": 505.45
              },
              {
                "number": 11,
                "value": 464.09,
                "total": 5105,
                "fee": 0.065,
                "convinience": 560.45
              },
              {
                "number": 12,
                "value": 425.42,
                "total": 5105,
                "fee": 0.065,
                "convinience": 560.45
              }
            ]
          }
        }
      ''';

      final Iterable l = json.decode(mockPaymentOptionsString)['options']['installments'];
      final mockPaymentOptions = List<PaymentOption>.from(l.map((model) => PaymentOption.fromJson(model))).toList();

      Uri uri = Uri.parse('https://dreamy-allen-2e1b47.netlify.app/payment-options.json');

      when(mockHttpClient
          .get(uri))
          .thenAnswer(
              (_) async => Future.value(http.Response(mockPaymentOptionsString, 200)));

      expect(await mockPaymentApiClient.fetchPaymentOptions(), mockPaymentOptions);
    });

    test('return Exception if http call error', () async {
      Uri uri = Uri.parse('https://dreamy-allen-2e1b47.netlify.app/payment-options.json');

      when(mockHttpClient
          .get(uri))
          .thenAnswer((_) async =>
          Future.value(http.Response('Something went wrong.', 202)));

      expect(() async => await mockPaymentApiClient.fetchPaymentOptions(),
          throwsA(isException));
    });
  });
}