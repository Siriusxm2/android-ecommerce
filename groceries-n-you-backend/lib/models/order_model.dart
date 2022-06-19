import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final int id;
  final int customerId;
  final List<int> productsId;
  final num subtotal;
  final num deliveryFee;
  final num voucher;
  final num total;
  final bool isAccepted;
  final bool isCanceled;
  final bool isDelivered;
  final DateTime createdAt;

  const OrderModel({
    required this.id,
    required this.customerId,
    required this.productsId,
    required this.subtotal,
    required this.deliveryFee,
    required this.voucher,
    required this.total,
    required this.isAccepted,
    required this.isCanceled,
    required this.isDelivered,
    required this.createdAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      customerId,
      productsId,
      subtotal,
      deliveryFee,
      voucher,
      total,
      isAccepted,
      isCanceled,
      isDelivered,
      createdAt,
    ];
  }

  OrderModel copyWith({
    int? id,
    int? customerId,
    List<int>? productsId,
    num? subtotal,
    num? deliveryFee,
    num? voucher,
    num? total,
    bool? isAccepted,
    bool? isCanceled,
    bool? isDelivered,
    DateTime? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productsId: productsId ?? this.productsId,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      voucher: voucher ?? this.voucher,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isCanceled: isCanceled ?? this.isCanceled,
      isDelivered: isDelivered ?? this.isDelivered,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'customer_id': customerId});
    result.addAll({'products_id': productsId});
    result.addAll({'subtotal': subtotal});
    result.addAll({'delivery_fee': deliveryFee});
    result.addAll({'voucher': voucher});
    result.addAll({'total': total});
    result.addAll({'is_accepted': isAccepted});
    result.addAll({'is_canceled': isCanceled});
    result.addAll({'is_delivered': isDelivered});
    result.addAll({'created_at': createdAt.millisecondsSinceEpoch});

    return result;
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snap) {
    return OrderModel(
      id: snap['id'],
      customerId: snap['customer_id'],
      productsId: List<int>.from(snap['products_id']),
      subtotal: snap['subtotal'],
      deliveryFee: snap['delivery_fee'],
      voucher: snap['voucher'],
      total: snap['total'],
      isAccepted: snap['is_accepted'],
      isCanceled: snap['is_canceled'],
      isDelivered: snap['is_delivered'],
      createdAt: snap['created_at'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'OrderModel(id: $id, customerId: $customerId, productsId: $productsId, subtotal: $subtotal, deliveryFee: $deliveryFee, voucher: $voucher, total: $total, isAccepted: $isAccepted, isDelivered: $isDelivered, createdAt: $createdAt)';
  }

  static List<OrderModel> orders = [
    OrderModel(
      id: 1,
      customerId: 141,
      productsId: const [2, 3],
      subtotal: 10.00,
      deliveryFee: 5.00,
      voucher: 0.0,
      total: 15.00,
      isAccepted: false,
      isCanceled: false,
      isDelivered: false,
      createdAt: DateTime.now(),
    ),
    OrderModel(
      id: 2,
      customerId: 142,
      productsId: const [1, 3, 5],
      subtotal: 10.00,
      deliveryFee: 5.00,
      voucher: 0.0,
      total: 15.00,
      isAccepted: false,
      isCanceled: false,
      isDelivered: false,
      createdAt: DateTime.now(),
    ),
  ];
}
