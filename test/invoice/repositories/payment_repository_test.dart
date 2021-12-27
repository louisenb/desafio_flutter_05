import 'package:desafio5/invoice/repositories/payment_api_client.dart';
import 'package:desafio5/invoice/repositories/payment_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPaymentApiClient extends Mock implements PaymentApiClient {}

void main() {
  group('fetchPaymentOptions', () {
    final mockPaymentRepository = PaymentRepository(paymentApiClient: MockPaymentApiClient());

    test('should called fetchPaymentOptions from PaymentApiClient', () async {
      when(mockPaymentRepository.fetchPaymentOptions()).thenAnswer((_) async {
        return Future.value();
      });

      mockPaymentRepository.fetchPaymentOptions();

      verify(mockPaymentRepository.fetchPaymentOptions()).called(1);
    });
  });
}