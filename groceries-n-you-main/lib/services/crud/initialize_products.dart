// import 'package:flutter/material.dart';
// import 'package:groceries_n_you/models/product_model.dart';
// import 'package:groceries_n_you/services/crud/orders_service.dart';
// import 'package:groceries_n_you/splash_screen.dart';

// class InitDbProducts extends StatefulWidget {
//   const InitDbProducts({Key? key}) : super(key: key);

//   @override
//   State<InitDbProducts> createState() => _InitDbProductsState();
// }

// class _InitDbProductsState extends State<InitDbProducts> {
//   late OrdersService _ordersService;

//   @override
//   void initState() {
//     _ordersService = OrdersService();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _ordersService.getAllProducts(),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.done:
//             ProductModel.products.clear();
//             final product = snapshot.data as Iterable<DatabaseProduct>;
//             if (ProductModel.products.isNotEmpty) {
//               product.toList().asMap().forEach((index, prod) {
//                 if (ProductModel.products[index].name != prod.productName) {
//                   ProductModel.products.add(const ProductModel().setProducts(
//                     prod.productName,
//                     prod.productManufacturer,
//                     prod.productPicture,
//                     prod.productPrice,
//                     prod.isSale,
//                     prod.saleAmount,
//                   ));
//                 }
//               });
//             } else {
//               product.toList().asMap().forEach((index, prod) {
//                 ProductModel.products.add(const ProductModel().setProducts(
//                   prod.id,
//                   prod.productName,
//                   prod.productManufacturer,
//                   prod.productPicture,
//                   prod.productPrice,
//                   prod.isSale,
//                   prod.saleAmount,
//                 ));
//               });
//             }
//             return const SplashScreen();
//           default:
//             return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
