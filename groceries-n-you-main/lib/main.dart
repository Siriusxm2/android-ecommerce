import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:groceries_n_you/services/auth/auth_service.dart';
import 'package:groceries_n_you/simple_bloc_observer.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:groceries_n_you/constants/routes.dart';

import 'blocs/blocs.dart';
import 'repositories/repositories.dart';
import 'utils/page_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.firebase().initialize();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Groceries 'N' You",
      theme: ThemeData(
        primarySwatch: generateMaterialColor(
          color: const Color(0xff699BFF),
        ),
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => AuthRepository()),
          RepositoryProvider(create: (context) => UserRepository()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => CartBloc()..add(LoadCart())),
            BlocProvider(
                create: (_) => PaymentBloc()..add(LoadPaymentMethod())),
            BlocProvider(
              create: (context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
                userRepository: context.read<UserRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => CheckoutBloc(
                cartBloc: context.read<CartBloc>(),
                paymentBloc: context.read<PaymentBloc>(),
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
            onGenerateRoute: PageRouter.onGenerateRoute,
            initialRoute: splashRoute,
          ),
        ),
      ),
    );
  }
}
