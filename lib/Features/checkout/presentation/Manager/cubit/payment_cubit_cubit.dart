import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/Features/checkout/data/Models/payment_intent_input.dart';
import 'package:payment_app/Features/checkout/data/repos/checkout_repo.dart';

part 'payment_cubit_state.dart';

class PaymentCubit extends Cubit<PaymentCubitState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentCubitInitial());
  final CheckoutRepo checkoutRepo;

  Future makePayment(
      {required PaymentintentInput paymentIntentInputModel}) async {
    emit(PaymentLoading());

    var data = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);

    data.fold(
      (l) => emit(PaymentFailure(l.errMessage)),
      (r) => emit(
        PaymentSuccess(),
      ),
    );
  }

  @override
  void onChange(Change<PaymentCubitState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
