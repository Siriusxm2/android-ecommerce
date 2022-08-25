import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../dimensions.dart';

class MyOrderSummaryWidget extends StatelessWidget {
  late String voucher;
  MyOrderSummaryWidget({Key? key, required this.voucher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: Dimensions.height20),
                width: MediaQuery.of(context).size.width - Dimensions.width30,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal:',
                          style: TextStyle(fontSize: Dimensions.font14),
                        ),
                        Text(
                          state.cart.subtotalString,
                          style: TextStyle(
                            fontSize: Dimensions.font14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery:',
                          style: TextStyle(fontSize: Dimensions.font14),
                        ),
                        Text(
                          '5.00 лв.',
                          style: TextStyle(
                            fontSize: Dimensions.font14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Voucher:',
                          style: TextStyle(fontSize: Dimensions.font14),
                        ),
                        Text(
                          voucher == 'TEST10' ? '-10.00 лв.' : '-0.00 лв.',
                          style: TextStyle(
                            fontSize: Dimensions.font14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // total strip
              Container(
                width: MediaQuery.of(context).size.width - Dimensions.width20,
                height: Dimensions.height50 / 2,
                color: const Color(0xffFFCE81),
                margin: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width5),
                      child: Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: Dimensions.font14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.width5),
                      child: Text(
                        state.cart.totalDouble.toStringAsFixed(2) + ' лв.',
                        style: TextStyle(
                          fontSize: Dimensions.font14 + (Dimensions.font14 / Dimensions.font14),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Text('Something went wron!');
        }
      },
    );
  }
}
