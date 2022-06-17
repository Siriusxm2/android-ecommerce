import 'package:groceries_n_you/models/product_model.dart';

abstract class BaseProductRepository {
  Stream<List<ProductModel>> getAllProducts();
}
