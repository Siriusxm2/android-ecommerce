import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groceries_n_you/models/product_model.dart';
import 'package:groceries_n_you/repositories/product/base_product_repo.dart';

class ProductRepository extends BaseProductRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProductRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<ProductModel>> getAllProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    });
  }
}
