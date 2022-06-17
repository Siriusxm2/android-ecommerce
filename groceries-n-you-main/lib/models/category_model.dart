import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String name;
  final String image;

  const CategoryModel({
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [
        name,
        image,
      ];

  static CategoryModel fromSnapshot(DocumentSnapshot snap) {
    CategoryModel category =
        CategoryModel(name: snap['name'], image: snap['image']);
    return category;
  }

  static List<CategoryModel> categories = [];
}
