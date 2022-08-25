import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/custom_widget_functions.dart';
import 'package:groceries_n_you/dimensions.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:groceries_n_you/models/models.dart';
import 'package:http/http.dart' as http;

import '../blocs/blocs.dart';
import '../constants/prices.dart';
import '../myWidgets/widgets.dart';

class FinalizePage extends StatelessWidget {
  FinalizePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: finalizeRoute),
      builder: (context) => FinalizePage(),
    );
  }

  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarHeader(label: 'Finalize'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // delivery info
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                      vertical: Dimensions.height20,
                    ),
                    child: BlocBuilder<CheckoutBloc, CheckoutState>(
                      builder: (context, state) {
                        if (state is CheckoutLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (state is CheckoutLoaded) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: Dimensions.height10),
                                child: Center(
                                  child: Text(
                                    'Delivery Information',
                                    style: TextStyle(
                                      fontSize: Dimensions.font16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              _customRow(context, 'Name:', state.name!),
                              _customRow(context, 'Email:', state.email!),
                              _customRow(context, 'Address:', state.address!),
                              _customRow(context, 'Phone:', state.phone!),
                              _customRow(context, 'Delivery Date:', state.deliveryDate!),
                              _customRow(context, 'Delivery Hour:', state.deliveryTime!),
                              _customRow(context, 'Payment Method:', state.paymentMethod == PaymentMethodModel.cash ? 'Cash' : 'Debit Card'),
                            ],
                          );
                        } else {
                          return const Text('Something went wrong!');
                        }
                      },
                    ),
                  ),
                  const Divider(
                    indent: 10,
                    endIndent: 10,
                    height: 1,
                    thickness: 1,
                    color: Color(0xffcccccc),
                  ),
                  // cart info
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                      vertical: Dimensions.height20,
                    ),
                    child: BlocBuilder<CheckoutBloc, CheckoutState>(
                      builder: (context, state) {
                        if (state is CheckoutLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is CheckoutLoaded) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: Dimensions.height10),
                                child: Center(
                                  child: Text(
                                    'Cart',
                                    style: TextStyle(
                                      fontSize: Dimensions.font16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              _customRow(context, 'Subtotal:', '${state.subtotal!.toStringAsFixed(2)} лв.'),
                              _customRow(context, 'Delivery Fee:', '${state.deliveryFee!.toStringAsFixed(2)} лв.'),
                              _customRow(context, 'Voucher:', '-${state.voucher!.toStringAsFixed(2)} лв.'),
                              _customRow(context, 'Total:', '${state.total!.toStringAsFixed(2)} лв.'),
                            ],
                          );
                        } else {
                          return const Text('Something went wrong!');
                        }
                      },
                    ),
                  ),
                  // order button
                  BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      if (state is CheckoutLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is CheckoutLoaded) {
                        return Container(
                          width: Dimensions.width320 / 2,
                          height: Dimensions.height30,
                          margin: EdgeInsets.only(
                            top: Dimensions.height10,
                            bottom: Dimensions.height20,
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              switch (state.paymentMethod) {
                                case PaymentMethodModel.cash:
                                  context.read<CheckoutBloc>().add(ConfirmCheckout(checkout: state.checkout));
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    orderSuccessRoute,
                                    (route) => false,
                                  );
                                  break;
                                case PaymentMethodModel.creditCard:
                                  await initPaymentSheet(
                                    context,
                                    email: state.email!,
                                    address: state.address!,
                                    phone: state.phone!,
                                    name: state.name!,
                                    amount: state.total!,
                                  );
                                  context.read<CheckoutBloc>().add(ConfirmCheckout(checkout: state.checkout));
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    orderSuccessRoute,
                                    (route) => false,
                                  );
                                  context.read<CartBloc>().add(ResetCart());
                                  pricesVoucher = 0.0;
                                  break;

                                default:
                                  context.read<CheckoutBloc>().add(ConfirmCheckout(checkout: state.checkout));
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    orderSuccessRoute,
                                    (route) => false,
                                  );
                                  break;
                              }
                            },
                            child: const Center(
                              child: Text(
                                'Order',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              primary: const Color(0xff8EB4FF),
                              side: const BorderSide(
                                color: Color(0xffFFAE2D),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Text('Something went wrong!');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
    );
  }

  Future<void> initPaymentSheet(
    context, {
    required String email,
    required String address,
    required String phone,
    required String name,
    required num amount,
  }) async {
    try {
      final response = await http.post(
          Uri.parse(
            'https://us-central1-groceries-n-you.cloudfunctions.net/stripePaymentIntentRequest',
          ),
          body: {
            'email': email,
            'address': address,
            'phone': phone,
            'name': name,
            'amount': (amount * 100).toString(),
          });

      final jsonResponse = jsonDecode(response.body);
      log(jsonResponse.toString());

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          merchantDisplayName: "Groceries 'N' You",
          merchantCountryCode: 'BG',
          customerId: jsonResponse['customer'],
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
          style: ThemeMode.system,
          testEnv: true,
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      CustomWidgets.mySnackBarWidget(context, 'Payment Complete!');
    } catch (e) {
      if (e is StripeException) {
        CustomWidgets.mySnackBarWidget(
          context,
          'Error from Stripe: ${e.error.localizedMessage}',
        );
      } else {
        CustomWidgets.mySnackBarWidget(
          context,
          'Error from Stripe: $e',
        );
      }
    }
  }
}

Padding _customRow(BuildContext context, String label, String content) {
  return Padding(
    padding: EdgeInsets.only(bottom: Dimensions.height5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: Dimensions.font16),
        ),
        Text(
          content,
          style: TextStyle(fontSize: Dimensions.font16),
        ),
      ],
    ),
  );
}
