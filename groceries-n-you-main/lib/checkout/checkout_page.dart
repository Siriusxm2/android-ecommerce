import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_n_you/constants/order_info.dart';
import 'package:groceries_n_you/dimensions.dart';
import 'package:groceries_n_you/models/payment_method_model.dart';
import 'package:intl/intl.dart';
import 'package:pay/pay.dart';
import 'dart:math' as math;

import '../blocs/blocs.dart';
import '../constants/routes.dart';
import '../myWidgets/widgets.dart';
import '../services/auth/auth_service.dart';
import 'delivery_hours.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: checkoutRoute),
      builder: (context) => const CheckoutPage(),
    );
  }

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late TextEditingController _dateController;
  late DateTime selectedDate;
  late var deliveryHours = DeliveryHours().hours;
  late String chosenHour = DeliveryHours().hours[0];
  final user = AuthService.firebase().currentUser;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _dateController.text = DateFormat('d MMM y').format(selectedDate);
    }
  }

  @override
  void initState() {
    _dateController = TextEditingController();
    selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarHeader(label: 'Checkout'),
      drawer: const MyDrawer(),
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
      body: Column(
        children: [
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CheckoutLoaded) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: Dimensions.height20),
                      child: Column(
                        children: [
                          // Order info
                          Padding(
                            padding: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                              bottom: Dimensions.height20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: Dimensions.height10),
                                  child: Text(
                                    'Enter order information',
                                    style: TextStyle(
                                      fontSize: Dimensions.font14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                _customTextFormField(
                                  (value) {
                                    orderInfoName = value;
                                    context.read<CheckoutBloc>().add(
                                          UpdateCheckout(name: value),
                                        );
                                  },
                                  context,
                                  'Name',
                                  (user != null) ? user!.displayName : null,
                                ),
                                _customTextFormField(
                                  (value) {
                                    orderInfoEmail = value;
                                    context.read<CheckoutBloc>().add(
                                          UpdateCheckout(email: value),
                                        );
                                  },
                                  context,
                                  'Email',
                                  (user != null) ? user!.email : null,
                                ),
                                _customTextFormField(
                                  (value) {
                                    orderInfoAddress = value;
                                    context.read<CheckoutBloc>().add(UpdateCheckout(address: value));
                                  },
                                  context,
                                  'Order Address',
                                  null,
                                ),
                                _customTextFormField(
                                  (value) {
                                    orderInfoPhone = value;
                                    context.read<CheckoutBloc>().add(UpdateCheckout(phone: value));
                                  },
                                  context,
                                  'Phone',
                                  null,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: const Color(0xffcccccc),
                            indent: Dimensions.width10,
                            endIndent: Dimensions.width10,
                          ),
                          // Delivery date
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width20,
                              vertical: Dimensions.height20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: Dimensions.height10),
                                  child: Text(
                                    'Delivery date',
                                    style: TextStyle(
                                      fontSize: Dimensions.font14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                // Delivery date
                                Padding(
                                  padding: EdgeInsets.only(bottom: Dimensions.height5),
                                  child: SizedBox(
                                    height: Dimensions.height30,
                                    child: TextFormField(
                                      controller: _dateController,
                                      focusNode: AlwaysDisabledFocusNode(),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(Dimensions.border5),
                                          ),
                                          borderSide: const BorderSide(
                                            color: Color(0xffD4D4D4),
                                          ),
                                        ),
                                        hintText: 'Delivery date',
                                        hintStyle: const TextStyle(
                                          color: Color(0xff959595),
                                        ),
                                        contentPadding: EdgeInsets.only(left: Dimensions.width10),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            _selectDate(context);
                                          },
                                          child: const Icon(
                                            Icons.insert_invitation,
                                            color: Color(0xffcccccc),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // delivery hour
                                Padding(
                                  padding: EdgeInsets.only(bottom: Dimensions.height5),
                                  child: SizedBox(
                                    height: Dimensions.height30,
                                    child: InputDecorator(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          value: chosenHour,
                                          icon: const Icon(Icons.keyboard_arrow_down),
                                          items: deliveryHours.map((String hour) {
                                            return DropdownMenuItem(
                                              value: hour,
                                              child: Text(hour),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              chosenHour = value!;
                                            });
                                            context.read<CheckoutBloc>().add(UpdateCheckout(deliveryTime: value));
                                          },
                                        ),
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(Dimensions.border5),
                                          ),
                                          borderSide: const BorderSide(
                                            color: Color(0xffD4D4D4),
                                          ),
                                        ),
                                        hintText: 'Delivery hour',
                                        hintStyle: const TextStyle(
                                          color: Color(0xff959595),
                                        ),
                                        contentPadding: EdgeInsets.only(left: Dimensions.width10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: const Color(0xffcccccc),
                            indent: Dimensions.width10,
                            endIndent: Dimensions.width10,
                          ),
                          // Payment method
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                            child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.border10)),
                                  ),
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        top: Dimensions.height10,
                                        left: Dimensions.width10,
                                        right: Dimensions.width10,
                                      ),
                                      child: BlocBuilder<PaymentBloc, PaymentState>(
                                        builder: (context, state) {
                                          if (state is PaymentLoading) {
                                            return const Center(child: CircularProgressIndicator());
                                          }
                                          if (state is PaymentLoaded) {
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width - Dimensions.width20,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      context.read<PaymentBloc>().add(const SelectPaymentMethod(paymentMethodModel: PaymentMethodModel.cash));
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      primary: const Color(0xff8EB4FF),
                                                    ),
                                                    child: Center(
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            top: -(Dimensions.height5),
                                                            left: 0,
                                                            child: Image.asset('assets/cash_pay.png'),
                                                          ),
                                                          const Align(
                                                            child: Text('Cash'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width - Dimensions.width20,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      context.read<PaymentBloc>().add(
                                                            const SelectPaymentMethod(
                                                              paymentMethodModel: PaymentMethodModel.creditCard,
                                                            ),
                                                          );

                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      primary: const Color(0xff8EB4FF),
                                                    ),
                                                    child: Center(
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            top: -(Dimensions.height5),
                                                            left: 0,
                                                            child: Image.asset('assets/card_pay.png'),
                                                          ),
                                                          const Align(
                                                            child: Text('Card'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return const Text('Something went wrong!');
                                          }
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Center(
                                child: Text(
                                  'Select Payment',
                                  style: TextStyle(color: Color(0xff333333)),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                primary: const Color(0xff8EB4FF),
                                side: const BorderSide(color: Color(0xffFFAE2D)),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: const Color(0xffcccccc),
                            indent: Dimensions.width10,
                            endIndent: Dimensions.width10,
                          ),
                          // finalize button
                          Container(
                            width: Dimensions.width320 / 2,
                            height: Dimensions.height30,
                            margin: EdgeInsets.only(
                              top: Dimensions.height10,
                              bottom: Dimensions.height20,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<CheckoutBloc>().add(
                                      UpdateCheckout(
                                        name: (user != null) ? user!.displayName : null,
                                        email: (user != null) ? user!.email : null,
                                        deliveryDate: _dateController.text,
                                      ),
                                    );
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  finalizeRoute,
                                  (route) => true,
                                );
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const Center(
                                    child: Text(
                                      'Finalize',
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Transform.rotate(
                                      angle: 90 * math.pi / 180,
                                      child: const Icon(
                                        Icons.expand_less,
                                        color: Color(0xff666666),
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                primary: const Color(0xff8EB4FF),
                                side: const BorderSide(
                                  color: Color(0xffFFAE2D),
                                ),
                              ),
                            ),
                          ),
                        ],
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
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

Padding _customTextFormField(
  Function(String)? onChanged,
  BuildContext context,
  String label,
  String? initialVal,
) {
  return Padding(
    padding: EdgeInsets.only(bottom: Dimensions.height5),
    child: SizedBox(
      height: Dimensions.height30,
      child: Stack(
        children: [
          TextFormField(
            onChanged: onChanged,
            initialValue: initialVal,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.border5),
                ),
                borderSide: const BorderSide(
                  color: Color(0xffD4D4D4),
                ),
              ),
              //isDense: true,
              contentPadding: EdgeInsets.only(left: Dimensions.width12),
              hintText: label,
              hintStyle: const TextStyle(
                color: Color(0xff959595),
              ),
            ),
          ),
          Positioned(
            top: -4,
            right: -1,
            child: Text(
              '*',
              style: TextStyle(
                color: const Color(0xffff0000),
                fontSize: Dimensions.font18,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
