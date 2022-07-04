import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:groceries_n_you/services/auth/auth_service.dart';
import 'package:groceries_n_you/services/auth/firebase_auth_provider.dart';
import 'package:groceries_n_you/services/auth/user_auth_state.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:groceries_n_you/constants/routes.dart';

import 'blocs/blocs.dart';
import 'repositories/repositories.dart';
import 'utils/page_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51LHMJzBzars1Xj9a5AJ0moJbYBZmLPV86CG4iEtMeVlVapaB6gv77TCB5ZsuAyFoS3Ldn2F0r1Hdg87IRUUoLn0m00WRIxOZyQ';
  await Stripe.instance.applySettings();
  await AuthService.firebase().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartBloc()..add(LoadCart())),
        BlocProvider(create: (_) => PaymentBloc()..add(LoadPaymentMethod())),
        BlocProvider(create: (context) => AuthBloc(FirebaseAuthProvider())),
        BlocProvider(
          create: (context) => CheckoutBloc(
            cartBloc: context.read<CartBloc>(),
            paymentBloc: context.read<PaymentBloc>(),
            checkoutRepository: CheckoutRepository(),
          ),
        ),
        BlocProvider(create: (_) => CategoryBloc(categoryRepository: CategoryRepository())..add(LoadCategories())),
        BlocProvider(create: (_) => ProductBloc(productRepository: ProductRepository())..add(LoadProducts())),
      ],
      child: GetMaterialApp(
        title: "Groceries 'N' You",
        theme: ThemeData(primarySwatch: generateMaterialColor(color: const Color(0xff699BFF))),
        onGenerateRoute: PageRouter.onGenerateRoute,
        initialRoute: splashRoute,
        home: const UserAuthState(),
      ),
    );
  }
}
