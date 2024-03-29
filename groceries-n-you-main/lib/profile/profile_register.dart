import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:groceries_n_you/custom_widget_functions.dart';
import 'package:groceries_n_you/dimensions.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/customIcons/custom_icons_icons.dart';
import 'package:groceries_n_you/models/user_model.dart';
import 'package:groceries_n_you/repositories/user/user_repo.dart';
import 'package:groceries_n_you/services/auth/auth_exceptions.dart';
import 'package:groceries_n_you/services/auth/auth_service.dart';
import 'package:groceries_n_you/services/crud/orders_service.dart';

import '../blocs/blocs.dart';
import '../services/auth/user_auth_state.dart';
import '../utils/dialogs/error_dialog.dart';
import '../myWidgets/widgets.dart';

class ProfileRegister extends StatefulWidget {
  const ProfileRegister({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: registerRoute),
      builder: (context) => const ProfileRegister(),
    );
  }

  @override
  State<ProfileRegister> createState() => _ProfileRegisterPageState();
}

class _ProfileRegisterPageState extends State<ProfileRegister> {
  late final TextEditingController _email;
  late final TextEditingController _name;
  late final TextEditingController _password;
  late final TextEditingController _address;
  late final TextEditingController _phone;
  late final OrdersService _ordersService;
  bool _obscurePassword = true;

  final UserRepository userRepository = UserRepository();

  // bool _obscurePassword2 = true;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
    _address = TextEditingController();
    _phone = TextEditingController();
    _ordersService = OrdersService();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    _address.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarHeader(label: 'Register an Account'),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: Dimensions.height10),
            // name
            SizedBox(
              width: Dimensions.width300,
              height: Dimensions.height30,
              child: TextField(
                controller: _name,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(
                    Dimensions.width12,
                    0,
                    Dimensions.width10,
                    0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.border10),
                    ),
                    borderSide: const BorderSide(color: Color(0xffD4D4D4)),
                  ),
                  hintText: 'Enter your name...',
                  hintStyle: const TextStyle(color: Color(0xff959595)),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            // email
            SizedBox(
              width: Dimensions.width300,
              height: Dimensions.height30,
              child: TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(
                    Dimensions.width12,
                    0,
                    Dimensions.width10,
                    0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.border10),
                    ),
                    borderSide: const BorderSide(color: Color(0xffD4D4D4)),
                  ),
                  hintText: 'Enter email...',
                  hintStyle: const TextStyle(color: Color(0xff959595)),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            // password
            SizedBox(
              width: Dimensions.width300,
              height: Dimensions.height30,
              child: TextField(
                controller: _password,
                enableSuggestions: false,
                autocorrect: false,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(
                    Dimensions.width12,
                    0,
                    Dimensions.width10,
                    0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.border10),
                    ),
                    borderSide: const BorderSide(color: Color(0xffD4D4D4)),
                  ),
                  hintText: 'Enter password...',
                  hintStyle: const TextStyle(
                    color: Color(0xff959595),
                  ),
                  suffixIcon: GestureDetector(
                    child: Icon(
                      _obscurePassword ? CustomIcons.eyeOff : CustomIcons.eye,
                      color: const Color(0xff666666),
                      size: 20,
                    ),
                    onTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  suffixIconColor: const Color(0xff666666),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            // address
            SizedBox(
              width: Dimensions.width300,
              height: Dimensions.height30,
              child: TextField(
                controller: _address,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(
                    Dimensions.width12,
                    0,
                    Dimensions.width10,
                    0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.border10),
                    ),
                    borderSide: const BorderSide(color: Color(0xffD4D4D4)),
                  ),
                  hintText: 'Enter your address...',
                  hintStyle: const TextStyle(color: Color(0xff959595)),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            // phone
            SizedBox(
              width: Dimensions.width300,
              height: Dimensions.height30,
              child: TextField(
                controller: _phone,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(
                    Dimensions.width12,
                    0,
                    Dimensions.width10,
                    0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.border10),
                    ),
                    borderSide: const BorderSide(color: Color(0xffD4D4D4)),
                  ),
                  hintText: 'Enter phone number...',
                  hintStyle: const TextStyle(color: Color(0xff959595)),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            Column(
              children: [
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) async {
                    if (state is AuthStateRegistering) {
                      if (state.exception is WeakPasswordAuthException) {
                        await showErrorDialog(context, 'Password is too weak!');
                      } else if (state.exception is EmailAlreadyInUseAuthException) {
                        await showErrorDialog(context, 'There is already an account with that email!');
                      } else if (state.exception is InvalidEmailAuthException) {
                        await showErrorDialog(context, 'Invalid email!');
                      } else if (state.exception is GenericAuthException) {
                        await showErrorDialog(context, 'Authentication error!');
                      }
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      final name = _name.text;
                      // final address = _address.text;
                      // final phone = _phone.text;

                      context.read<AuthBloc>().add(AuthRegister(email: email, password: password, name: name));
                      // final user = AuthService.firebase().currentUser;
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const UserAuthState()), (route) => false);
                    },
                    child: const Text(
                      'REGISTER',
                      style: TextStyle(
                        color: Color(0xff333333),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.border10),
                      ),
                      primary: const Color(0xff8EB4FF),
                      side: const BorderSide(
                        color: Color(0xffFFAE2D),
                      ),
                      fixedSize: Size(Dimensions.width340, Dimensions.height30),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, ((route) => true));
                  },
                  child: Container(
                    width: Dimensions.width340,
                    padding: EdgeInsets.only(left: Dimensions.width10),
                    child: Text(
                      'Already have a profile? Login here.',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: const Color(0xff333333),
                        fontSize: Dimensions.font10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: const MyDrawer(),
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
    );
  }
}
