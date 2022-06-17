import 'package:equatable/equatable.dart';

import '../constants/prices.dart';
import 'product_model.dart';

class CartModel extends Equatable {
  final List<ProductModel> products;

  const CartModel({this.products = const <ProductModel>[]});

  Map productQuantity(products) {
    var quantity = {};

    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });
    return quantity;
  }

  double get subtotal =>
      products.fold(0, (total, current) => total + current.price);

  double get deliveryFee => 5.00;

  double total(subtotal, deliveryFee) {
    return subtotal + deliveryFee;
  }

  double get voucher => pricesVoucher;

  String get subtotalString => subtotal.toStringAsFixed(2) + ' лв.';

  double get totalDouble => total(subtotal, deliveryFee);

  @override
  List<Object?> get props => [products];
}
