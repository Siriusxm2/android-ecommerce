import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gny_backend/controllers/product_controller.dart';
import 'package:intl/intl.dart';

import 'package:gny_backend/controllers/order_controller.dart';
import 'package:gny_backend/dimensions.dart';
import 'package:gny_backend/models/order_model.dart';

class OrdersPage extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());
  final ProductController productController = Get.put(ProductController());

  OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: orderController.pendingOrders.length,
                itemBuilder: (context, index) {
                  return OrderCard(order: orderController.pendingOrders[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final OrderController orderController = Get.find();
  final ProductController productController = Get.find();

  OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var products = productController.products
        .where((product) => order.productsId.contains(product.id))
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.width10,
        right: Dimensions.width10,
        top: Dimensions.height10,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.border10),
          side: const BorderSide(
            width: 2,
            color: Color(0xff4382FF),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width10,
            vertical: Dimensions.height10,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order ID: ${order.id}',
                    style: TextStyle(
                      fontSize: Dimensions.font16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(order.createdAt),
                    style: TextStyle(
                      fontSize: Dimensions.font16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        SizedBox(
                          height: Dimensions.height50,
                          width: Dimensions.width50,
                          child: Image.network(
                            products[index].picture,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: Dimensions.width10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index].name,
                              style: TextStyle(
                                fontSize: Dimensions.font16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: Dimensions.height5),
                            Text(
                              products[index].manu,
                              style: TextStyle(
                                fontSize: Dimensions.font12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: Dimensions.height10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Voucher',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${order.voucher} лв.',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${order.total.toStringAsFixed(2)} лв.',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  order.isAccepted
                      ? ElevatedButton(
                          onPressed: () {
                            orderController.updateOrder(
                              order,
                              'is_delivered',
                              !order.isDelivered,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                              Dimensions.width100,
                              Dimensions.height40,
                            ),
                            primary: const Color(0xff8EB4FF),
                            side: const BorderSide(
                              color: Color(0xffFFAE2D),
                            ),
                          ),
                          child: const Text(
                            'Deliver',
                            style: TextStyle(
                              color: Color(0xff333333),
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            orderController.updateOrder(
                              order,
                              'is_accepted',
                              !order.isAccepted,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                              Dimensions.width100,
                              Dimensions.height40,
                            ),
                            primary: const Color(0xff8EB4FF),
                            side: const BorderSide(
                              color: Color(0xffFFAE2D),
                            ),
                          ),
                          child: const Text(
                            'Accept',
                            style: TextStyle(
                              color: Color(0xff333333),
                            ),
                          ),
                        ),
                  ElevatedButton(
                    onPressed: () {
                      orderController.updateOrder(
                        order,
                        'is_canceled',
                        !order.isCanceled,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        Dimensions.width100,
                        Dimensions.height40,
                      ),
                      primary: const Color(0xff8EB4FF),
                      side: const BorderSide(
                        color: Color(0xffFFAE2D),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xff333333),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
