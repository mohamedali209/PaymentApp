import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_app/Features/checkout/data/Models/ephemeralkey/ephemeralkey.dart';
import 'package:payment_app/Features/checkout/data/Models/initpaymentshett_inputmodel.dart';
import 'package:payment_app/Features/checkout/data/Models/payment_intent_input.dart';
import 'package:payment_app/Features/checkout/data/Models/paymentintentmodel/paymentintentmodel.dart';
import 'package:payment_app/core/utils/api_service.dart';
import 'package:payment_app/core/utils/apikeys.dart';

class Stripeservice {
  Apiservice apiservice = Apiservice();

  Future<Paymentintentmodel> createpaymentintent(
      PaymentintentInput paymentintentInput) async {
    var body = paymentintentInput
        .toJson()
        .entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');

    var response = await apiservice.post(
      body: body,
      contenttype: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/payment_intents',
      token: Apikeys.secertkey,
    );
    var paymentintentmodel = Paymentintentmodel.fromJson(response.data);
    return paymentintentmodel;
  }

  Future initpaymentsheet(
      {Initpaymentsheetinputmodel? initpaymentsheetinputmodel}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret:
                initpaymentsheetinputmodel!.paymentIntentClientSecret,
            customerEphemeralKeySecret:
                initpaymentsheetinputmodel.ephemeralKeySecret,
            customerId: initpaymentsheetinputmodel.customerid,
            merchantDisplayName: 'mohamed'));
  }

  Future displaypaymentsheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makepayment({required PaymentintentInput paymentintentInput}) async {
    var paymentintentmodel = await createpaymentintent(paymentintentInput);
    var ephmeralkeymodel =
        await createEphmeralkey(customerid: paymentintentInput.customerid);

    var initpaymentinputsheetmodel = Initpaymentsheetinputmodel(
        customerid: paymentintentInput.customerid,
        ephemeralKeySecret: ephmeralkeymodel.secret!,
        paymentIntentClientSecret: paymentintentmodel.clientSecret!);
    await initpaymentsheet(
      initpaymentsheetinputmodel: initpaymentinputsheetmodel,
    );
    await displaypaymentsheet();
  }

  Future<Ephemeralkey> createEphmeralkey({required String customerid}) async {
    var response = await apiservice.post(
      body: {'customer': customerid},
      contenttype: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/ephemeral_keys',
      headers: {
        'Authorization': 'Bearer ${Apikeys.secertkey}',
        'Stripe-Version': '2024-04-10'
      },
      token: Apikeys.secertkey,
    );
    var ephmeralkey = Ephemeralkey.fromJson(response.data);
    return ephmeralkey;
  }
}
