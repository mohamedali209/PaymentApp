import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_app/Features/checkout/data/Models/payment_intent_input.dart';
import 'package:payment_app/Features/checkout/data/repos/checkout_repo.dart';
import 'package:payment_app/core/utils/errors/failure.dart';
import 'package:payment_app/core/utils/stripe.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final Stripeservice stripeService = Stripeservice();
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentintentInput paymentIntentInputModel}) async {
    try {
      await stripeService.makepayment(
        paymentintentInput: paymentIntentInputModel,
      );
      return right(null);
    } on StripeException catch (e) {
      return left(ServerFailure(
          errMessage: e.error.message ?? 'Oops there was an error'));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
