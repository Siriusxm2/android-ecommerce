import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String manu;
  final String picture;
  double price;
  bool isOnSale;
  int saleAmount;
  int inStorage;

  ProductModel({
    required this.id,
    required this.name,
    required this.manu,
    required this.picture,
    this.price = 0,
    this.isOnSale = false,
    this.saleAmount = 0,
    this.inStorage = 0,
  });

  @override
  List<Object> get props {
    return [
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

  ProductModel copyWith({
    int? id,
    String? name,
    String? manu,
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
      picture: picture ?? this.picture,
      price: price ?? this.price,
      isOnSale: isOnSale ?? this.isOnSale,
      saleAmount: saleAmount ?? this.saleAmount,
      inStorage: inStorage ?? this.inStorage,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'product_name': name});
    result.addAll({'product_manufacturer': manu});
    result.addAll({'product_image': picture});
    result.addAll({'product_price': price});
    result.addAll({'is_sale': isOnSale});
    result.addAll({'sale_amount': saleAmount});
    result.addAll({'in_storage': inStorage});

    return result;
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot snap) {
    return ProductModel(
      id: snap['id'],
      name: snap['product_name'],
      manu: snap['product_manufacturer'],
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

  static List<ProductModel> products = [
    ProductModel(
      id: 1,
      name: 'Amstel Premium Pilsener - 0,5 Л кен',
      manu: 'Amstel',
      picture:
          'https://firebasestorage.googleapis.com/v0/b/groceries-n-you.appspot.com/o/product_images%2FAmstel_Can.png?alt=media&token=8086186f-6ac0-4c68-bf9a-18bf7c095179',
      price: 1.28,
      isOnSale: true,
      saleAmount: 33,
      inStorage: 10,
    ),
    ProductModel(
      id: 2,
      name: 'Amstel Premium Pilsener - 0,5 Л стъкло',
      manu: 'Amstel',
      picture:
          'https://firebasestorage.googleapis.com/v0/b/groceries-n-you.appspot.com/o/product_images%2FAmstel_Glass.png?alt=media&token=733e4671-ebb8-4d85-a70f-f6b7a898d529',
      price: 1.4,
      isOnSale: false,
      saleAmount: 0,
      inStorage: 10,
    ),
    ProductModel(
      id: 3,
      name: 'Ариана светло пиво - 0,5Л кен',
      manu: 'Ariana',
      picture:
          'https://firebasestorage.googleapis.com/v0/b/groceries-n-you.appspot.com/o/product_images%2FAriana_Can.png?alt=media&token=a0e573c1-90cb-4c96-a847-86bcdb5e20ea',
      price: 0.9,
      isOnSale: false,
      saleAmount: 0,
      inStorage: 10,
    ),
    ProductModel(
      id: 4,
      name: 'Ариана светло пиво - 0,5Л стъкло',
      manu: 'Ariana',
      picture:
          'https://firebasestorage.googleapis.com/v0/b/groceries-n-you.appspot.com/o/product_images%2FAriana_Glass.png?alt=media&token=b7ce94db-75de-4764-b3b0-62aa3cd3c3de',
      price: 1.08,
      isOnSale: true,
      saleAmount: 20,
      inStorage: 10,
    ),
    ProductModel(
      id: 5,
      name: 'Heineken светло пиво - 0,5Л кен',
      manu: 'Heineken',
      picture:
          'https://firebasestorage.googleapis.com/v0/b/groceries-n-you.appspot.com/o/product_images%2FHeineken_Can.png?alt=media&token=bc97d555-3762-457c-ad7d-4b71309192af',
      price: 0.89,
      isOnSale: false,
      saleAmount: 0,
      inStorage: 10,
    ),
  ];
}
