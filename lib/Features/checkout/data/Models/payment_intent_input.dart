class PaymentintentInput {
  final String amount;
  final String currency;
  final String customerid;

  PaymentintentInput(
      {required this.customerid, required this.amount, required this.currency});
  toJson() {
    return {
      'amount': '${amount}00',
      'currency': currency,
      'customer': customerid
    };
  }
}
