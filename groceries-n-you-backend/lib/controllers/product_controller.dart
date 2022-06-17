import 'package:get/get.dart';
import 'package:gny_backend/services/database_service.dart';

import '../models/product_model.dart';

class ProductController extends GetxController {
  final DatabaseService database = DatabaseService();

  var products = <ProductModel>[].obs;
  var newProduct = {}.obs;

  @override
  void onInit() {
    products.bindStream(database.getProducts());
    super.onInit();
  }

  get price => newProduct['product_price'];
  get isSale => newProduct['is_sale'];
  get saleAmount => newProduct['sale_amount'];
  get inStorage => newProduct['in_storage'];

  void updateProductPrice(
    int index,
    ProductModel product,
    double value,
  ) {
    product.price = value;
    products[index] = product;
  }

  void saveNewProductPrice(
    ProductModel product,
    String field,
    double value,
  ) {
    database.updateField(product, field, value);
  }

  void updateProductIsSale(
    int index,
    ProductModel product,
    bool value,
  ) {
    product.isOnSale = value;
    products[index] = product;
  }

  void saveNewProductIsSale(
    ProductModel product,
    String field,
    bool value,
  ) {
    database.updateField(product, field, value);
  }

  void updateProductSaleAmount(
    int index,
    ProductModel product,
    int value,
  ) {
    product.saleAmount = value;
    products[index] = product;
  }

  void saveNewProductSaleAmount(
    ProductModel product,
    String field,
    int value,
  ) {
    database.updateField(product, field, value);
  }

  void updateProductInStorage(
    int index,
    ProductModel product,
    int value,
  ) {
    product.inStorage = value;
    products[index] = product;
  }

  void saveNewProductInStorage(
    ProductModel product,
    String field,
    int value,
  ) {
    database.updateField(product, field, value);
  }
}
