import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_app/core/utils/apikeys.dart';
import 'package:payment_app/core/utils/widgets/cutom_app_bar.dart';
import 'package:payment_app/my_cart_view_body.dart';

void main() {
  Stripe.publishableKey = Apikeys.publishedkey;
  runApp(const PayApp());
}

class PayApp extends StatelessWidget {
  const PayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'My Cart'),
      body: const MyCartViewBody(),
    );
  }
}
