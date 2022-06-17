import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_n_you/dimensions.dart';
import 'package:groceries_n_you/models/product_model.dart';

import 'blocs/blocs.dart';

class CustomWidgets {
  CustomWidgets._();

  static mySnackBarWidget(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xff333333),
        ),
      ),
      backgroundColor: const Color(0xffFFBE57),
      duration: const Duration(milliseconds: 2000),
      behavior: SnackBarBehavior.floating,
      width: Dimensions.width200,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(0xff699BFF),
        ),
        borderRadius: BorderRadius.circular(Dimensions.border10),
      ),
    ));
  }

  static List<Widget> promotionGrid(
    bool isSale,
    num originalPrice,
    int saleAmount,
    int quantity,
  ) {
    final q = quantity;
    if (isSale) {
      final percentOff = originalPrice * saleAmount / 100;
      final salePrice = originalPrice - percentOff;
      final result = salePrice * q;
      return [
        // Price and currency
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: Dimensions.font18,
              fontWeight: FontWeight.w900,
              color: const Color(0xff333333),
            ),
            children: [
              TextSpan(
                  text: result < 1
                      ? salePrice.toStringAsFixed(2)
                      : result.toStringAsFixed(2)),
              const TextSpan(text: ' лв.'),
            ],
          ),
        ),
        // Sale ticket
        Stack(
          children: [
            Image.asset(
              'assets/saleTicket.png',
            ),
            Container(
              padding: EdgeInsets.only(left: Dimensions.width10),
              width: Dimensions.width40,
              height: Dimensions.font24,
              child: Align(
                child: Text(
                  '-$saleAmount%',
                  style: TextStyle(fontSize: Dimensions.font12),
                ),
              ),
            ),
          ],
        ),
      ];
    } else {
      final result = originalPrice * q;
      return [
        // Price and currency
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: Dimensions.font18,
              fontWeight: FontWeight.w900,
              color: const Color(0xff333333),
            ),
            children: [
              TextSpan(
                  text: result < 1
                      ? originalPrice.toStringAsFixed(2)
                      : result.toStringAsFixed(2)),
              const TextSpan(text: ' лв.'),
            ],
          ),
        ),
      ];
    }
  }

  static List<Widget> promotionList(
    bool isSale,
    num originalPrice,
    int saleAmount,
    int quantity,
  ) {
    final q = quantity;
    if (isSale) {
      final percentOff = originalPrice * saleAmount / 100;
      final salePrice = originalPrice - percentOff;
      final result = salePrice * q;
      return [
        // Price and currency
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: Dimensions.font14,
              fontWeight: FontWeight.w900,
              color: const Color(0xff333333),
            ),
            children: [
              TextSpan(
                  text: result < 1
                      ? salePrice.toStringAsFixed(2)
                      : result.toStringAsFixed(2)),
              const TextSpan(text: ' лв.'),
            ],
          ),
        ),
        // Sale ticket
        Padding(
          padding: EdgeInsets.only(left: Dimensions.width10),
          child: Stack(
            children: [
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationX(math.pi),
                child: Image.asset(
                  'assets/saleTicket.png',
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: Dimensions.width10),
                width: Dimensions.width40,
                height: Dimensions.font24,
                child: Align(
                  child: Text(
                    '-$saleAmount%',
                    style: TextStyle(fontSize: Dimensions.font12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ];
    } else {
      final result = originalPrice * q;
      return [
        // Price and currency
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: Dimensions.font18,
              fontWeight: FontWeight.w900,
              color: const Color(0xff333333),
            ),
            children: [
              TextSpan(
                  text: result < 1
                      ? originalPrice.toStringAsFixed(2)
                      : result.toStringAsFixed(2)),
              const TextSpan(text: ' лв.'),
            ],
          ),
        ),
      ];
    }
  }

  static List<Widget> isPromotionGrid({
    required ProductModel product,
    required int quantity,
  }) {
    if (product.isOnSale) {
      return [
        // Picture
        Container(
          height: Dimensions.height170,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffc4c4c4),
              width: 1,
            ),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(product.picture),
            ),
          ),
        ),
        // Stars and cart
        Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star,
                    size: 16,
                    color: Color(0xff4382FF),
                  ),
                ),
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return Center(
                      child: SizedBox(
                        height: Dimensions.height50 / 2,
                        width: Dimensions.width50 / 2,
                        child: const CircularProgressIndicator(
                          color: Color(0xffFFBE57),
                        ),
                      ),
                    );
                  } else if (state is CartLoaded) {
                    return InkWell(
                      onTap: () {
                        context.read<CartBloc>().add(AddProduct(product));
                      },
                      child: Image.asset('assets/cart.png'),
                    );
                  } else {
                    return const Text('Something went wrong!');
                  }
                },
              ),
            ],
          ),
        ),
        // Name
        SizedBox(
          height: Dimensions.height15 * 2,
          child: Text(
            product.name,
            style: TextStyle(
              fontSize: Dimensions.font13,
              color: const Color(0xff333333),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // Manufacturer
        Padding(
          padding: EdgeInsets.only(
            top: Dimensions.height5,
            bottom: Dimensions.height8,
          ),
          child: Text(
            product.manu,
            style: TextStyle(
              fontSize: Dimensions.font12,
              fontWeight: FontWeight.w400,
              color: const Color(0xffcccccc),
            ),
          ),
        ),
        // Price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: promotionGrid(
              product.isOnSale, product.price, product.saleAmount, quantity),
        ),
        // Old Price
        Stack(
          children: [
            SizedBox(
              width: Dimensions.width60,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: Dimensions.font14,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xffCCCCCC),
                  ),
                  children: [
                    TextSpan(text: product.price.toStringAsFixed(2)),
                    const TextSpan(text: ' лв.'),
                  ],
                ),
              ),
            ),
            Positioned(
              top: Dimensions.height8,
              child: Transform.rotate(
                angle: -35 * math.pi / 180,
                child: Container(
                  color: const Color(0xffCCCCCC),
                  width: Dimensions.width40,
                  height: Dimensions.height3,
                ),
              ),
            ),
          ],
        ),
      ];
    } else {
      return [
        // Picture
        Container(
          height: Dimensions.height170,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffcccccc),
              width: 1,
            ),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(product.picture),
            ),
          ),
        ),
        // Stars and cart
        Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star,
                    size: 16,
                    color: Color(0xff4382FF),
                  ),
                ),
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return Center(
                      child: SizedBox(
                        height: Dimensions.height50 / 2,
                        width: Dimensions.width50 / 2,
                        child: const CircularProgressIndicator(
                          color: Color(0xffFFBE57),
                        ),
                      ),
                    );
                  } else if (state is CartLoaded) {
                    return InkWell(
                      onTap: () {
                        context.read<CartBloc>().add(AddProduct(product));
                      },
                      child: Image.asset('assets/cart.png'),
                    );
                  } else {
                    return const Text('Something went wrong!');
                  }
                },
              ),
            ],
          ),
        ),
        // Name
        SizedBox(
          height: Dimensions.height15 * 2,
          child: Text(
            product.name,
            style: TextStyle(
              fontSize: Dimensions.font13,
              color: const Color(0xff333333),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // Manufacturer
        Padding(
          padding: EdgeInsets.only(
            top: Dimensions.height5,
            bottom: Dimensions.height8,
          ),
          child: Text(
            product.manu,
            style: TextStyle(
              fontSize: Dimensions.font12,
              fontWeight: FontWeight.w400,
              color: const Color(0xffcccccc),
            ),
          ),
        ),
        // Price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: promotionGrid(
              product.isOnSale, product.price, product.saleAmount, quantity),
        ),
      ];
    }
  }

  static List<Widget> isPromotionList({
    required ProductModel product,
    required int quantity,
  }) {
    if (product.isOnSale) {
      return [
        // Picture
        Container(
          width: Dimensions.width115,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffc4c4c4),
              width: 1,
            ),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(product.picture),
            ),
          ),
        ),
        Container(
          width: (Dimensions.width115 * 2) +
              Dimensions.width5 +
              (Dimensions.width8 / 4),
          padding: EdgeInsets.only(left: Dimensions.width20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              SizedBox(
                height: Dimensions.height15 * 2,
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: Dimensions.font14,
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Manufacturer
              Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.height5),
                child: Text(
                  product.manu,
                  style: TextStyle(
                    fontSize: Dimensions.font12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xffcccccc),
                  ),
                ),
              ),
              // Stars and cart
              Padding(
                padding: EdgeInsets.only(bottom: Dimensions.height8),
                child: Wrap(
                  children: List.generate(
                    5,
                    (index) => const Icon(
                      Icons.star,
                      size: 16,
                      color: Color(0xff4382FF),
                    ),
                  ),
                ),
              ),
              // pricve
              Row(
                children: [
                  // Old Price
                  Stack(
                    children: [
                      SizedBox(
                        width: Dimensions.width60,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: Dimensions.font13,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xffCCCCCC),
                            ),
                            children: [
                              TextSpan(text: product.price.toStringAsFixed(2)),
                              const TextSpan(text: ' лв.'),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: Dimensions.height8,
                        child: Transform.rotate(
                          angle: -35 * math.pi / 180,
                          child: Container(
                            color: const Color(0xffCCCCCC),
                            width: Dimensions.width40,
                            height: Dimensions.height3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: promotionList(product.isOnSale, product.price,
                        product.saleAmount, quantity),
                  ),
                ],
              ),
              // Buy button
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return Center(
                      child: SizedBox(
                        height: Dimensions.height50 / 2,
                        width: Dimensions.width50 / 2,
                        child: const CircularProgressIndicator(
                          color: Color(0xffFFBE57),
                        ),
                      ),
                    );
                  } else if (state is CartLoaded) {
                    return SizedBox(
                      height: Dimensions.height50 / 2,
                      width: Dimensions.width50 + Dimensions.width5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xffFFBE57),
                          side: const BorderSide(
                            color: Color(0xff699BFF),
                          ),
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          fixedSize: Size(Dimensions.height50 / 2,
                              Dimensions.width50 + Dimensions.width5),
                          maximumSize: Size(Dimensions.height50 / 2,
                              Dimensions.width50 + Dimensions.width5),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.border5),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          '+ BUY',
                          style: TextStyle(
                            fontSize: Dimensions.font12,
                            color: const Color(0xff333333),
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
      ];
    } else {
      return [
        // Picture
        Container(
          width: Dimensions.width115,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffc4c4c4),
              width: 1,
            ),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(product.picture),
            ),
          ),
        ),
        Container(
          width: (Dimensions.width115 * 2) +
              Dimensions.width5 +
              (Dimensions.width8 / 4),
          padding: EdgeInsets.only(left: Dimensions.width20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              SizedBox(
                height: Dimensions.height15 * 2,
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: Dimensions.font13,
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Manufacturer
              Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.height5),
                child: Text(
                  product.manu,
                  style: TextStyle(
                    fontSize: Dimensions.font12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xffcccccc),
                  ),
                ),
              ),
              // Stars and cart
              Padding(
                padding: EdgeInsets.only(bottom: Dimensions.height8),
                child: Wrap(
                  children: List.generate(
                    5,
                    (index) => const Icon(
                      Icons.star,
                      size: 16,
                      color: Color(0xff4382FF),
                    ),
                  ),
                ),
              ),
              // Price
              Padding(
                padding: EdgeInsets.only(bottom: Dimensions.height2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: promotionList(product.isOnSale, product.price,
                      product.saleAmount, quantity),
                ),
              ),
              // Buy button
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return Center(
                      child: SizedBox(
                        height: Dimensions.height50 / 2,
                        width: Dimensions.width50 / 2,
                        child: const CircularProgressIndicator(
                          color: Color(0xffFFBE57),
                        ),
                      ),
                    );
                  } else if (state is CartLoaded) {
                    return SizedBox(
                      height: Dimensions.height50 / 2,
                      width: Dimensions.width50 + Dimensions.width5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xffFFBE57),
                          side: const BorderSide(
                            color: Color(0xff699BFF),
                          ),
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          fixedSize: Size(Dimensions.height50 / 2,
                              Dimensions.width50 + Dimensions.width5),
                          maximumSize: Size(Dimensions.height50 / 2,
                              Dimensions.width50 + Dimensions.width5),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.border5),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          '+ BUY',
                          style: TextStyle(
                            fontSize: Dimensions.font12,
                            color: const Color(0xff333333),
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
      ];
    }
  }
}
