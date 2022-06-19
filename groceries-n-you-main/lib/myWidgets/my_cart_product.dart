import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../dimensions.dart';
import '../models/product_model.dart';

class MyCartProductWidget extends StatelessWidget {
  final ProductModel product;
  final int quantity;

  const MyCartProductWidget({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.height20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffc4c4c4),
                    width: 1,
                  ),
                ),
                width: Dimensions.width80 + Dimensions.width12,
                height: Dimensions.height70,
                child: Image.network(
                  product.picture,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                width: MediaQuery.of(context).size.width -
                    Dimensions.width20 -
                    (Dimensions.width80 + Dimensions.width12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Dimensions.width200 + Dimensions.width10,
                          child: Text(
                            product.name,
                            style: TextStyle(
                              fontSize: Dimensions.font14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff333333),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Color(0xffFFAE2D),
                          ),
                          onPressed: () {
                            for (int i = 0; i < quantity; i++) {
                              context
                                  .read<CartBloc>()
                                  .add(RemoveProduct(product));
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.manu,
                      style: TextStyle(
                        fontSize: Dimensions.font10,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff333333),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(right: Dimensions.width10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff333333),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffFFBE57),
                  ),
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (quantity != 1) {
                                context
                                    .read<CartBloc>()
                                    .add(RemoveProduct(product));
                              }
                            },
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Container(
                            width: Dimensions.width30,
                            height: Dimensions.height30,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Color(0xff333333),
                                  width: 1,
                                ),
                                right: BorderSide(
                                  color: Color(0xff333333),
                                  width: 1,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            child: Text(
                              '$quantity',
                              style: TextStyle(
                                fontSize: Dimensions.font18,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.read<CartBloc>().add(AddProduct(product));
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Text(
                  product.isOnSale
                      ? (product.price -
                                  (product.price * product.saleAmount / 100))
                              .toStringAsFixed(2) +
                          ' лв.'
                      : product.price.toStringAsFixed(2) + ' лв.',
                  style: TextStyle(
                    fontSize: Dimensions.font14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff333333),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
