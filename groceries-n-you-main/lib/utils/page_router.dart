import 'package:flutter/material.dart';
import 'package:groceries_n_you/about/about_page.dart';
import 'package:groceries_n_you/about/contacts_page.dart';
import 'package:groceries_n_you/cart/cart_page.dart';
import 'package:groceries_n_you/categories/category_page.dart';
import 'package:groceries_n_you/checkout/checkout_page.dart';
import 'package:groceries_n_you/checkout/finalize_order.dart';
import 'package:groceries_n_you/checkout/order_sent.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/homePage/home_page.dart';
import 'package:groceries_n_you/models/category_model.dart';
import 'package:groceries_n_you/profile/profile.dart';
import 'package:groceries_n_you/profile/profile_email_verify.dart';
import 'package:groceries_n_you/profile/profile_login.dart';
import 'package:groceries_n_you/profile/profile_register.dart';
import 'package:groceries_n_you/profile/users/orders/profile_orders.dart';
import 'package:groceries_n_you/profile/users/settings_view.dart';
import 'package:groceries_n_you/splash_screen.dart';

class PageRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case homeRoute:
        return HomePage.route();
      case splashRoute:
        return SplashScreen.route();
      case cartRoute:
        return CartPage.route();
      case categoryRoute:
        return CategoryPage.route(
          category: settings.arguments as CategoryModel,
        );
      case checkoutRoute:
        return CheckoutPage.route();
      case finalizeRoute:
        return FinalizePage.route();
      case orderSuccessRoute:
        return OrderSentPage.route();
      case profileRoute:
        return ProfileView.route();
      case profileSettingsRoute:
        return ProfileSettingsView.route();
      case profileOrdersRoute:
        return ProfileOrdersPage.route();
      case loginRoute:
        return ProfileLogin.route();
      case registerRoute:
        return ProfileRegister.route();
      case verifyRoute:
        return VerifyEmail.route();
      case aboutRoute:
        return AboutUsPage.route();
      case contactRoute:
        return ContactsPage.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
