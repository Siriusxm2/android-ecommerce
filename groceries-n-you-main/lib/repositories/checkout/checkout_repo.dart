import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groceries_n_you/models/checkout_model.dart';
import 'package:groceries_n_you/repositories/checkout/base_checkout_repo.dart';

class CheckoutRepository extends BaseCheckoutRepository {
  final FirebaseFirestore _firebaseFirestore;

  CheckoutRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addCheckout(CheckoutModel checkout) {
    return _firebaseFirestore.collection('checkout').add(checkout.toDocument());
  }
}
