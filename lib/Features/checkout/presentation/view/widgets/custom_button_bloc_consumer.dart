import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/Features/checkout/data/Models/payment_intent_input.dart';
import 'package:payment_app/Features/checkout/presentation/Manager/cubit/payment_cubit_cubit.dart';
import 'package:payment_app/core/utils/widgets/custom_button.dart';
import 'package:payment_app/thank_you_view.dart';

class CustombuttonblocConsumer extends StatelessWidget {
  const CustombuttonblocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentCubitState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ThankYouView(),
              ));
        }
        if (state is PaymentFailure) {
          Navigator.pop(context);
          print(state.errMessage);
        }
      },
      builder: (context, state) {
        return CustomButton(
            onTap: () {
              PaymentintentInput paymentintentInput = PaymentintentInput(
                  amount: '100',
                  currency: 'USD',
                  customerid: 'cus_QHEp1rMBGccaa5');
              BlocProvider.of<PaymentCubit>(context)
                  .makePayment(paymentIntentInputModel: paymentintentInput);
            },
            isloading: state is PaymentLoading ? true : false,
            text: 'Continue');
      },
    );
  }
}
