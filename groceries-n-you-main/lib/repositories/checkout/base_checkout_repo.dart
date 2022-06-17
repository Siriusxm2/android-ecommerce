import 'package:groceries_n_you/models/checkout_model.dart';

abstract class BaseCheckoutRepository {
  Future<void> addCheckout(CheckoutModel checkout);
}
