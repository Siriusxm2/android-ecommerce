import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String address;
  final String phone;

  const UserModel({
    this.id,
    this.name = '',
    this.email = '',
    this.address = '',
    this.phone = '',
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? address,
    String? phone,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    return UserModel(
      id: snap.id,
      name: snap['name'],
      email: snap['email'],
      address: snap['address'],
      phone: snap['phone'],
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      address,
      phone,
    ];
  }
}
