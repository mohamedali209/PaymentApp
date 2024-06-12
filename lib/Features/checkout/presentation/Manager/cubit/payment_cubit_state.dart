part of 'payment_cubit_cubit.dart';

sealed class PaymentCubitState {}

final class PaymentCubitInitial extends PaymentCubitState {}

final class PaymentLoading extends PaymentCubitState {}

final class PaymentSuccess extends PaymentCubitState {}

final class PaymentFailure extends PaymentCubitState {
  final String errMessage;

  PaymentFailure(this.errMessage);
}
