import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../constants/prices.dart';
import '../myWidgets/widgets.dart';
import '../../constants/routes.dart';
import '../dimensions.dart';

class CartFullPage extends StatefulWidget {
  const CartFullPage({Key? key}) : super(key: key);

  @override
  State<CartFullPage> createState() => _CartFullPageState();
}

class _CartFullPageState extends State<CartFullPage> {
  late TextEditingController _voucher;
  late String voucher;

  @override
  void initState() {
    _voucher = TextEditingController();
    voucher = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // image
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    width:
                        MediaQuery.of(context).size.width - Dimensions.width20,
                    height: Dimensions.height150 + Dimensions.height10,
                    child: Image.asset(
                      'assets/cart_add.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  // Product strip
                  Container(
                    margin: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height10,
                    ),
                    width:
                        MediaQuery.of(context).size.width - Dimensions.width20,
                    height: Dimensions.height50 / 2,
                    color: const Color(0xffB4CDFF),
                    alignment: Alignment.center,
                    child: Text(
                      'Products',
                      style: TextStyle(
                        color: const Color(0xff333333),
                        fontSize: Dimensions.font14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  // PRODUCT SHOWCASE
                  SizedBox(
                    width:
                        MediaQuery.of(context).size.width - Dimensions.width20,
                    child: LimitedBox(
                      maxHeight: Dimensions.height200 + Dimensions.height180,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.cart
                            .productQuantity(state.cart.products)
                            .keys
                            .length,
                        itemBuilder: (context, index) {
                          return MyCartProductWidget(
                            product: state.cart
                                .productQuantity(state.cart.products)
                                .keys
                                .elementAt(index),
                            quantity: state.cart
                                .productQuantity(state.cart.products)
                                .values
                                .elementAt(index),
                          );
                        },
                      ),
                    ),
                  ),
                  // PRODUCT SHOWCASE END
                  // divider
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.height10),
                    child: Divider(
                      thickness: 1,
                      indent: Dimensions.width10,
                      endIndent: Dimensions.width10,
                      color: const Color(0xffcccccc),
                    ),
                  ),
                  // voucher
                  Container(
                    margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
                    width:
                        MediaQuery.of(context).size.width - Dimensions.width20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: Dimensions.width5),
                              child: Text(
                                'Add voucher',
                                style: TextStyle(
                                  fontSize: Dimensions.font14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: Dimensions.width5),
                              width: 20,
                              height: 20,
                              child: GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.help_outline,
                                  color: Color(0xff999999),
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: Dimensions.height10),
                          height: Dimensions.height50 / 2,
                          child: TextField(
                            controller: _voucher,
                            autocorrect: false,
                            decoration: InputDecoration(
                              suffix: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(Dimensions.border10),
                                      ),
                                    ),
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    fixedSize: Size(
                                      Dimensions.width50,
                                      Dimensions.height50 / 2,
                                    )),
                                onPressed: () {
                                  setState(() {
                                    voucher = _voucher.text;
                                  });
                                },
                                child: const Text('Add'),
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: Dimensions.width12,
                                  right: Dimensions.width10 / 5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.border10),
                                ),
                                borderSide: const BorderSide(
                                  color: Color(0xffD4D4D4),
                                ),
                              ),
                              hintText: 'Enter voucher...',
                              hintStyle: const TextStyle(
                                color: Color(0xff959595),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // prices
                  MyOrderSummaryWidget(voucher: voucher),
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
                        pricesSubTotal = state.cart.subtotal;
                        pricesDeliveryFee = 5;
                        pricesVoucher = voucher == 'TEST10' ? 10.00 : 0;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          checkoutRoute,
                          (route) => true,
                        );
                      },
                      child: const Center(
                        child: Text(
                          'Checkout',
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
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Text('Something went wrong!');
        }
      },
    );
  }
}
