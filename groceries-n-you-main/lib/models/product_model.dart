import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String manu;
  final String picture;
  final double price;
  final bool isOnSale;
  final int saleAmount;
  final int inStorage;

  const ProductModel({
    required this.id,
    required this.name,
    required this.manu,
    required this.picture,
    required this.price,
    required this.isOnSale,
    required this.saleAmount,
    required this.inStorage,
  });

  static List<ProductModel> products = [];

  static ProductModel fromSnapshot(DocumentSnapshot snap) {
    ProductModel product = ProductModel(
      id: snap['id'],
      name: snap['product_name'],
      manu: snap['product_manufacturer'],
      picture: snap['product_image'],
      price: snap['product_price'],
      isOnSale: snap['is_sale'],
      saleAmount: snap['sale_amount'],
      inStorage: snap['in_storage'],
    );
    return product;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        manu,
        picture,
        price,
        isOnSale,
        saleAmount,
        inStorage,
      ];
}
