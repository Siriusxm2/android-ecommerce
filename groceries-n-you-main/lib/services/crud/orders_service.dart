import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:groceries_n_you/services/auth/auth_exceptions.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'crud_exceptions.dart';

class OrdersService {
  Database? _db;
  Database? _dbP;
  List<DatabaseOrder> _orders = [];
  List<DatabaseProduct> _products = [];
  List<DatabaseUser> _users = [];

  late final StreamController<List<DatabaseProduct>> _productsStreamController;
  Stream<List<DatabaseProduct>> get allProducts =>
      _productsStreamController.stream;

  late final StreamController<List<DatabaseUser>> _usersStreamController;
  Stream<List<DatabaseUser>> get allUsers => _usersStreamController.stream;

  // SINGLETON
  static final OrdersService _shared = OrdersService._sharedInstance();
  OrdersService._sharedInstance() {
    _productsStreamController =
        StreamController<List<DatabaseProduct>>.broadcast(
      onListen: () {
        _productsStreamController.sink.add(_products);
      },
    );
    _usersStreamController = StreamController<List<DatabaseUser>>.broadcast(
      onListen: () {
        _usersStreamController.sink.add(_users);
      },
    );
    _ordersStreamController = StreamController<List<DatabaseOrder>>.broadcast(
      onListen: () {
        _ordersStreamController.sink.add(_orders);
      },
    );
  }
  factory OrdersService() => _shared;
  // SINGLETON

  late final StreamController<List<DatabaseOrder>> _ordersStreamController;
  Stream<List<DatabaseOrder>> get allOrders => _ordersStreamController.stream;

  Future<void> _cacheOrders() async {
    final allOrders = await getAllOrders();
    _orders = allOrders.toList();
    _ordersStreamController.add(_orders);
  }

  Future<void> _cacheProducts() async {
    final allProducts = await getAllProducts();
    _products = allProducts.toList();
    _productsStreamController.add(_products);
  }

  Future<void> _cacheUsers() async {
    final allUsers = await getAllUsers();
    _users = allUsers.toList();
    _usersStreamController.add(_users);
  }

  // USER ACTIONS
  Future<DatabaseUser> createUser({
    required String name,
    required String email,
    required String address,
    required String phone,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (results.isNotEmpty) {
      throw UserAlreadyExistsException();
    }

    final userId = await db.insert(userTable, {
      nameColumn: name,
      emailColumn: email.toLowerCase(),
      addressColumn: address,
      phoneColumn: phone,
    });

    return DatabaseUser(
      id: userId,
      name: name,
      email: email,
      address: address,
      phone: phone,
    );
  }

  Future<DatabaseUser> getUser({required String email}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (results.isEmpty) {
      throw CouldNotFindUserException();
    } else {
      final user = DatabaseUser.fromRow(results.first);
      _users.removeWhere((user) => user.email == email);
      _users.add(user);
      _usersStreamController.add(_users);
      return user;
    }
  }

  Future<Iterable<DatabaseUser>> getAllUsers() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final users = await db.query(userTable);

    final result = users.map((n) => DatabaseUser.fromRow(users.first));
    return result;
  }

  Future<String> getUserName({required String email}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      columns: [nameColumn],
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (results.isEmpty) {
      throw UserNotFoundAuthException();
    } else {
      return results.first.values.first.toString();
    }
  }

  // Future<DatabaseUser> getOrCreateUser({required String email}) async {
  //   try {
  //     final user = await getUser(email: email);
  //     return user;
  //   } on CouldNotFindUserException {
  //     final createdUser = await createUser(email: email);
  //     return createdUser;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> deleteUser({required String email}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      userTable,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (deletedCount != 1) throw CouldNotDeleteUserException();
  }

  // ORDER ACTIONS
  Future<DatabaseOrder> createOrder({
    required DatabaseUser owner,
    required DatabaseProduct product,
  }) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final dbUser = await getUser(email: owner.email);
    final dbProduct = await getProduct(name: product.productName);

    // Make sure owner exists in database with correct id
    if (dbUser != owner) {
      throw CouldNotFindUserException();
    }

    if (dbProduct != product) {
      throw CouldNotFindProductException();
    }

    const orderSubTotal = 0.0;
    const orderDeliveryFee = 0.0;
    const orderVoucher = 0.0;
    const orderTotal = 0.0;
    const orderDate = '';
    const orderStatus = '';

    // Create the note
    final orderId = await db.insert(orderTable, {
      userIdColumn: owner.id,
      productIdColumn: product.id,
      orderSubTotalColumn: orderSubTotal,
      orderDeliveryFeeColumn: orderDeliveryFee,
      orderVoucherColumn: orderVoucher,
      orderTotalColumn: orderTotal,
      orderDateColumn: orderDate,
      orderStatusColumn: orderStatus,
      isSyncedWithCloudColumn: 1,
    });

    final order = DatabaseOrder(
      id: orderId,
      userId: owner.id,
      productId: product.id,
      subTotal: orderSubTotal,
      deliveryFee: orderDeliveryFee,
      voucher: orderVoucher,
      total: orderTotal,
      orderDate: orderDate,
      orderStatus: orderStatus,
      isSyncedWithCloud: true,
    );

    _orders.add(order);
    _ordersStreamController.add(_orders);

    return order;
  }

  Future<DatabaseOrder> getOrder({required int id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final orders = await db.query(
      orderTable,
      limit: 1,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (orders.isEmpty) {
      throw CouldNotFindOrderException();
    } else {
      final order = DatabaseOrder.fromRow(orders.first);
      _orders.removeWhere((order) => order.id == id);
      _orders.add(order);
      _ordersStreamController.add(_orders);
      return order;
    }
  }

  Future<Iterable<DatabaseOrder>> getAllOrders() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final orders = await db.query(orderTable);

    final result = orders.map((n) => DatabaseOrder.fromRow(orders.first));
    return result;
  }

  Future<void> deleteOrder({required int id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      orderTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (deletedCount == 0) {
      throw CouldNotDeleteOrderException();
    } else {
      _orders.removeWhere((order) => order.id == id);
      _ordersStreamController.add(_orders);
    }
  }

  Future<int> deleteAllOrders() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final numOfDeletions = await db.delete(orderTable);
    _orders = [];
    _ordersStreamController.add(_orders);

    return numOfDeletions;
  }

  Future<DatabaseProduct> getProduct({required String name}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      productTable,
      limit: 1,
      where: 'product_name = ?',
      whereArgs: [name],
    );
    if (results.isEmpty) {
      throw CouldNotFindProductException();
    } else {
      final product = DatabaseProduct.fromRow(results.first);
      _products.removeWhere((product) => product.productName == name);
      _products.add(product);
      _productsStreamController.add(_products);
      return product;
    }
  }

  Future<Iterable<DatabaseProduct>> getAllProducts() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final product = await db.query(productTable);

    final result = product.map((n) => DatabaseProduct.fromRow(n));
    return result;
  }

  // DATABASE ACTIONS
  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenException();
    } else {
      return db;
    }
  }

  Future<void> _ensureDbIsOpen() async {
    try {
      await open();
    } on DatabaseAlreadyOpenedException {
      // empty
    }
  }

  // INITIALIZE PRODUCTS.DB
  Future<void> _initializeProducts() async {
    final docsPath = await getApplicationDocumentsDirectory();
    final dbPath = join(docsPath.path, dbProducts);

    // Delete DB if exists
    await deleteDatabase(dbPath);

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", dbProducts));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes, flush: true);
  }

  Future<void> open() async {
    if (_db != null) {
      throw DatabaseAlreadyOpenedException();
    } else if (_dbP != null) {
      throw DatabaseAlreadyOpenedException();
    }
    try {
      // Initialize products.db
      await _initializeProducts();
      // Get path to products.db
      final docsPathProducts = await getApplicationDocumentsDirectory();
      final dbPathProducts = join(docsPathProducts.path, dbProducts);
      final dbP = await openDatabase(dbPathProducts);
      _dbP = dbP;

      // Get path to orders.db
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbOrders);
      final db = await openDatabase(dbPath);
      _db = db;

      // CREATE USER TABLE
      await db.execute(createUserTable);
      // CREATE ORDERS TABLE
      await db.execute(createOrdersTable);
      // CREATE PRODUCTS TABLE
      var tableCheck = Sqflite.firstIntValue(await db.query(
        'sqlite_master',
        where: 'name = ?',
        whereArgs: [productTable],
      ));
      if (tableCheck == 1) {
        await db.execute('delete from $productTable');
      }

      await db.execute('drop table if exists $productTable');
      await db.execute(createProductsTable);

      // COPY PRODUCTS.PRODUCTS TO ORDERS.PRODUCTS
      final dbProductsContent = await dbP.query(productTable);
      for (var row in dbProductsContent) {
        db.insert(productTable, row,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await _cacheProducts();
      await _cacheOrders();
      await _cacheUsers();
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectoryException();
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenException();
    } else {
      await db.close();
      _db = null;
    }
  }
}

// USERS TABLE
@immutable
class DatabaseUser {
  final int id;
  final String name;
  final String email;
  final String address;
  final String phone;

  const DatabaseUser({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
  });

  DatabaseUser.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        name = map[nameColumn] as String,
        email = map[emailColumn] as String,
        address = map[addressColumn] as String,
        phone = map[phoneColumn] as String;

  @override
  String toString() =>
      'Person: ID = $id, email = $email, Name = $name, Address = $address, Phone = $phone';

  @override
  bool operator ==(covariant DatabaseUser other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// ORDERS TABLE
@immutable
class DatabaseOrder {
  final int id;
  final int userId;
  final int productId;
  final num subTotal;
  final num deliveryFee;
  final num voucher;
  final num total;
  final String orderDate;
  final String orderStatus;
  final bool isSyncedWithCloud;

  const DatabaseOrder({
    required this.id,
    required this.userId,
    required this.productId,
    required this.subTotal,
    required this.deliveryFee,
    required this.voucher,
    required this.total,
    required this.orderDate,
    required this.orderStatus,
    required this.isSyncedWithCloud,
  });

  DatabaseOrder.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        userId = map[userIdColumn] as int,
        productId = map[productIdColumn] as int,
        subTotal = map[orderSubTotalColumn] as num,
        deliveryFee = map[orderDeliveryFeeColumn] as num,
        voucher = map[orderVoucherColumn] as num,
        total = map[orderTotalColumn] as num,
        orderDate = map[orderDateColumn] as String,
        orderStatus = map[orderStatusColumn] as String,
        isSyncedWithCloud =
            (map[isSyncedWithCloudColumn] as int) == 1 ? true : false;

  @override
  String toString() {
    return '''Sale:
              ID: $id, 
              UserID: $userId, 
              ProductID: $productId, 
              Synced: $isSyncedWithCloud, 
              OrderSubTotal: $subTotal,
              OrderDeliveryFee: $deliveryFee,
              OrderVoucher: $voucher,
              OrderTotal: $total,
              OrderDate: $orderDate, 
              OrderStatus: $orderStatus''';
  }

  @override
  bool operator ==(covariant DatabaseOrder other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// PRODUCTS TABLE
@immutable
class DatabaseProduct {
  final int id;
  final String productName;
  final String productManufacturer;
  final String productPicture;
  final double productPrice;
  final String productTag;
  final bool isSale;
  final int saleAmount;

  const DatabaseProduct({
    required this.id,
    required this.productName,
    required this.productManufacturer,
    required this.productPicture,
    required this.productPrice,
    required this.productTag,
    required this.isSale,
    required this.saleAmount,
  });

  DatabaseProduct.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        productName = map[productNameColumn] as String,
        productManufacturer = map[productManufacturerColumn] as String,
        productPicture = map[productPictureColumn] as String,
        productPrice = map[productPriceColumn] as double,
        isSale = (map[productIsSaleColumn] as int) == 1 ? true : false,
        saleAmount = map[productSaleAmountColumn] as int,
        productTag = map[productTagColumn] as String;

  @override
  String toString() =>
      'ID: $id, Name: $productName, Manufacturer: $productManufacturer, Picture: $productPicture, Price: $productPrice, IsSale: $isSale, SaleAmount: $saleAmount, Tag: $productTag';

  @override
  bool operator ==(covariant DatabaseProduct other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

const dbOrders = 'orders.db';
const dbProducts = 'products.db';
const orderTable = 'orders';
const userTable = 'users';
const productTable = 'products';
const idColumn = 'id';
const nameColumn = 'name';
const emailColumn = 'email';
const addressColumn = 'address';
const phoneColumn = 'phone';
const userIdColumn = 'user_id';
const productIdColumn = 'product_id';
const orderSubTotalColumn = 'order_subtotal';
const orderDeliveryFeeColumn = 'order_deliveryfee';
const orderVoucherColumn = 'order_voucher';
const orderTotalColumn = 'order_total';
const orderDateColumn = 'order_date';
const orderStatusColumn = 'order_status';
const productNameColumn = 'product_name';
const productManufacturerColumn = 'product_manufacturer';
const productPictureColumn = 'product_picture';
const productPriceColumn = 'product_price';
const productTagColumn = 'product_tag';
const productIsSaleColumn = 'is_sale';
const productSaleAmountColumn = 'sale_amount';
const isSyncedWithCloudColumn = 'is_synced_with_cloud';
const createUserTable = '''
        CREATE TABLE IF NOT EXISTS "users" (
	      "id"	INTEGER NOT NULL,
        "name" TEXT NOT NULL,
	      "email"	TEXT NOT NULL UNIQUE,
        "address" TEXT NOT NULL,
        "phone" TEXT NOT NULL,
	      PRIMARY KEY("id" AUTOINCREMENT)
        );''';
const createOrdersTable = ''' 
        CREATE TABLE IF NOT EXISTS "orders" (
	      "id"	INTEGER NOT NULL,
	      "user_id"	INTEGER NOT NULL,
	      "product_id"	INTEGER NOT NULL,
	      "order_subtotal"	REAL NOT NULL,
	      "order_deliveryfee"	REAL NOT NULL,
	      "order_voucher"	REAL NOT NULL,
	      "order_total"	REAL NOT NULL,
	      "order_date"	TEXT NOT NULL,
        "order_status" TEXT NOT NULL,
	      "is_synced_with_cloud"	INTEGER NOT NULL DEFAULT 0,
	      PRIMARY KEY("id" AUTOINCREMENT),
        FOREIGN KEY("product_id") REFERENCES "products",
	      FOREIGN KEY("user_id") REFERENCES "users"("id")
        );''';
const createProductsTable = '''
        CREATE TABLE IF NOT EXISTS "products" (
	      "id"	INTEGER NOT NULL,
	      "product_name"	TEXT NOT NULL,
	      "product_manufacturer"	TEXT NOT NULL,
	      "product_picture"	TEXT NOT NULL,
	      "product_price"	REAL NOT NULL,
        "is_sale"	INTEGER NOT NULL,
	      "sale_amount"	INTEGER NOT NULL,
        "product_tag"	TEXT NOT NULL,
	      PRIMARY KEY("id" AUTOINCREMENT)
        );''';
