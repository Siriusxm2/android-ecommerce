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
      picture: 'assets/products/beers/Amstel_Can.png',
      price: 1.28,
      isOnSale: true,
      saleAmount: 33,
      inStorage: 10,
    ),
    ProductModel(
      id: 2,
      name: 'Amstel Premium Pilsener - 0,5 Л стъкло',
      manu: 'Amstel',
      picture: 'assets/products/beers/Amstel_Glass.png',
      price: 1.4,
      isOnSale: false,
      saleAmount: 0,
      inStorage: 10,
    ),
    ProductModel(
      id: 3,
      name: 'Ариана светло пиво - 0,5Л кен',
      manu: 'Ariana',
      picture: 'assets/products/beers/Ariana_Can.png',
      price: 0.9,
      isOnSale: false,
      saleAmount: 0,
      inStorage: 10,
    ),
    ProductModel(
      id: 4,
      name: 'Ариана светло пиво - 0,5Л стъкло',
      manu: 'Ariana',
      picture: 'assets/products/beers/Ariana_Glass.png',
      price: 1.08,
      isOnSale: true,
      saleAmount: 20,
      inStorage: 10,
    ),
    ProductModel(
      id: 5,
      name: 'Heineken светло пиво - 0,5Л кен',
      manu: 'Heineken',
      picture: 'assets/products/beers/Heineken_Can.png',
      price: 0.89,
      isOnSale: false,
      saleAmount: 0,
      inStorage: 10,
    ),
  ];
}
