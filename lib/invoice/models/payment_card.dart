import 'card_type.dart';

class PaymentCard {
  late CardType type;
  late String number;
  late String name;
  late String expirationDate;
  late String cvv;

  PaymentCard(this.type, this.number, this.name, this.expirationDate, this.cvv);

  PaymentCard.empty() {
    this.type = CardType.Others;
    this.number = "";
    this.name = "";
    this.expirationDate = "";
    this.cvv = "";
  }
}