import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String? id;
  final String name;
  final String manu;
  final String category;
  final String picture;
  double price;
  bool isOnSale;
  int saleAmount;
  int inStorage;

  ProductModel({
    this.id,
    required this.name,
    required this.manu,
    required this.category,
    required this.picture,
    this.price = 0,
    this.isOnSale = false,
    this.saleAmount = 0,
    this.inStorage = 0,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      manu,
      category,
      picture,
      price,
      isOnSale,
      saleAmount,
      inStorage,
    ];
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? manu,
    String? category,
    String? picture,
    double? price,
    bool? isOnSale,
    int? saleAmount,
    int? inStorage,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      manu: manu ?? this.manu,
      category: category ?? this.category,
      picture: picture ?? this.picture,
      price: price ?? this.price,
      isOnSale: isOnSale ?? this.isOnSale,
      saleAmount: saleAmount ?? this.saleAmount,
      inStorage: inStorage ?? this.inStorage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_name': name,
      'product_manufacturer': manu,
      'product_category': category,
      'product_image': picture,
      'product_price': price,
      'is_sale': isOnSale,
      'sale_amount': saleAmount,
      'in_storage': inStorage,
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot snap) {
    return ProductModel(
      id: snap.id,
      name: snap['product_name'],
      manu: snap['product_manufacturer'],
      category: snap['product_category'],
      picture: snap['product_image'],
      price: snap['product_price'],
      isOnSale: snap['is_sale'],
      saleAmount: snap['sale_amount'],
      inStorage: snap['in_storage'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, manu: $manu, picture: $picture, price: $price, isOnSale: $isOnSale, saleAmount: $saleAmount, inStorage: $inStorage)';
  }

  static List<ProductModel> products = [];
}
