import 'package:dartz/dartz.dart';
import 'package:payment_app/Features/checkout/data/Models/payment_intent_input.dart';
import 'package:payment_app/core/utils/errors/failure.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentintentInput paymentIntentInputModel});
}
