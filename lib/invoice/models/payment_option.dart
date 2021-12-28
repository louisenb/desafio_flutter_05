import 'dart:ui';

class PaymentOption {
  late final int number;
  late final double value;
  late final double total;
  late final double convenience;

  PaymentOption(this.number, this.value, this.total, this.convenience);

  PaymentOption.empty() {
    this.number = 0;
    this.value = 0.0;
    this.total = 0.0;
    this.convenience = 0.0;
  }

  @override
  String toString() {
    return 'PaymentOption{number: $number, value: $value, total: $total, convenience: $convenience}';
  }

  PaymentOption.fromJson(Map<String, dynamic> json)
      : number = json['number'],
        value = json['value'].toDouble(),
        total = json['total'].toDouble(),
        convenience = json['convinience'].toDouble();

  bool operator == (o) =>
      o is PaymentOption &&
          number == o.number &&
          value == o.value &&
          total == o.total &&
          convenience == o.convenience;

  int get hashCode => hashValues(number, value, total);
}
