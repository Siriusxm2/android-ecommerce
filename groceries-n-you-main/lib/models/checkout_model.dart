import 'package:equatable/equatable.dart';

import 'product_model.dart';

class CheckoutModel extends Equatable {
  final String? name;
  final String? email;
  final String? address;
  final String? phone;
  final List<ProductModel>? products;
  final String? deliveryDate;
  final String? deliveryTime;
  final String? paymentMethod;
  final num? subtotal;
  final num? deliveryFee;
  final num? voucher;
  final num? total;

  const CheckoutModel({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.products,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.paymentMethod,
    required this.subtotal,
    required this.deliveryFee,
    required this.voucher,
    required this.total,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        address,
        phone,
        products,
        deliveryDate,
        deliveryTime,
        paymentMethod,
        subtotal,
        deliveryFee,
        voucher,
        total,
      ];

  Map<String, Object> toDocument() {
    Map customerInfo = {};
    Map orderInfo = {};

    customerInfo['name'] = name;
    customerInfo['email'] = email;
    customerInfo['address'] = address;
    customerInfo['phone'] = phone;

    orderInfo['payment_method'] = paymentMethod;
    orderInfo['delivery_date'] = deliveryDate;
    orderInfo['delivery_time'] = deliveryTime;

    return {
      'customerInfo': customerInfo,
      'orderInfo': orderInfo,
      'products': products!.map((product) => product.name).toList(),
      'order_subtotal': subtotal!,
      'order_deliveryFee': deliveryFee!,
      'order_voucher': voucher!,
      'order_total': total!,
    };
  }
}
