import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gny_backend/models/product_model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore;

  DatabaseService({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<ProductModel>> getProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    });
  }

  Future<void> addProduct(ProductModel product) {
    return _firebaseFirestore.collection('products').add(product.toMap());
  }

  Future<void> updateField(
    ProductModel product,
    String field,
    dynamic newValue,
  ) {
    return _firebaseFirestore
        .collection('products')
        .where('id', isEqualTo: product.id)
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.first.reference.update({field: newValue})
            });
  }
}
