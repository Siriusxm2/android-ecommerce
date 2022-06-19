import 'package:get/get.dart';

import '../cart/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
}
