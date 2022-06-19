import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:gny_backend/models/product_model.dart';

class OrderModel extends Equatable {
  final String? id;
  final int customerId;
  final List<String> productsId;
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
  List<Object?> get props {
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
    String? id,
    int? customerId,
    List<String>? productsId,
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

  factory OrderModel.fromSnapshot(DocumentSnapshot snap) {
    return OrderModel(
      id: snap.id,
      customerId: snap['customer_id'],
      productsId: List<String>.from(snap['products_id']).toList(),
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

  @override
  String toString() {
    return 'OrderModel(id: $id, customerId: $customerId, productsId: $productsId, subtotal: $subtotal, deliveryFee: $deliveryFee, voucher: $voucher, total: $total, isAccepted: $isAccepted, isDelivered: $isDelivered, createdAt: $createdAt)';
  }

  static List<OrderModel> orders = [];
}
