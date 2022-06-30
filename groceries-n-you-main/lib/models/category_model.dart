import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String name;
  final String image;
  final List<String> subcategories;

  const CategoryModel({
    required this.name,
    required this.image,
    required this.subcategories,
  });

  @override
  List<Object?> get props => [
        name,
        image,
        subcategories,
      ];

  factory CategoryModel.fromSnapshot(DocumentSnapshot snap) {
    return CategoryModel(
      name: snap['name'],
      image: snap['category_image'],
      subcategories: List<String>.from(snap['subcategories']).toList(),
    );
  }

  static List<CategoryModel> categories = [];
}
