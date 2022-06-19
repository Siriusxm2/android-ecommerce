import 'package:get/get.dart';
import 'package:gny_backend/models/order_model.dart';
import 'package:gny_backend/services/database_service.dart';

class OrderController extends GetxController {
  final DatabaseService database = DatabaseService();

  var orders = <OrderModel>[].obs;
  var pendingOrders = <OrderModel>[].obs;

  @override
  void onInit() {
    orders.bindStream(database.getOrders());
    pendingOrders.bindStream(database.getPendingOrders());
    super.onInit();
  }

  void updateOrder(
    OrderModel order,
    String field,
    bool value,
  ) {
    database.updateOrder(order, field, value);
  }
}
