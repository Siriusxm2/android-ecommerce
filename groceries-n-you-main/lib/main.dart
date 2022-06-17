import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:groceries_n_you/about/about_page.dart';
import 'package:groceries_n_you/about/contacts_page.dart';
import 'package:groceries_n_you/categories/category_page.dart';
import 'package:groceries_n_you/profile/users/orders/profile_orders.dart';
import 'package:groceries_n_you/profile/users/settings_view.dart';
import 'package:groceries_n_you/repositories/category/category_repo.dart';
import 'package:groceries_n_you/repositories/checkout/checkout_repo.dart';
import 'package:groceries_n_you/repositories/product/product_repo.dart';
import 'package:groceries_n_you/services/auth/firebase_user_auth.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/profile/profile_email_verify.dart';
import 'package:groceries_n_you/profile/profile_login.dart';
import 'package:groceries_n_you/profile/profile.dart';
import 'package:groceries_n_you/profile/profile_register.dart';

import 'blocs/blocs.dart';
import 'cart/cart_page.dart';
import 'checkout/checkout_page.dart';
import 'checkout/finalize_order.dart';
import 'checkout/order_sent.dart';
import 'homePage/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartBloc()..add(LoadCart())),
        BlocProvider(
          create: (context) => CheckoutBloc(
            cartBloc: context.read<CartBloc>(),
            checkoutRepository: CheckoutRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(LoadCategories()),
        ),
        BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(LoadProducts()),
        ),
      ],
      child: GetMaterialApp(
        title: "Groceries 'N' You",
        theme: ThemeData(
          primarySwatch: generateMaterialColor(
            color: const Color(0xff699BFF),
          ),
        ),
        home: const MyFirebaseUserAuth(), //const MyFirebaseUserAuth(),
        routes: {
          homeRoute: ((context) => const HomePage()),
          profileRoute: ((context) => ProfileView()),
          profileSettingsRoute: ((context) => const ProfileSettingsView()),
          profileOrdersRoute: ((context) => const ProfileOrdersPage()),
          loginRoute: ((context) => const ProfileLogin()),
          registerRoute: ((context) => const ProfileRegister()),
          verifyRoute: ((context) => const VerifyEmail()),
          aboutRoute: ((context) => const AboutUsPage()),
          contactRoute: ((context) => const ContactsPage()),
          categoryRoute: ((context) => const CategoryPage()),
          cartRoute: ((context) => const CartPage()),
          checkoutRoute: ((context) => const CheckoutPage()),
          finalizeRoute: ((context) => const FinalizePage()),
          orderSuccessRoute: ((context) => const OrderSentPage()),
        },
      ),
    );
  }
}
