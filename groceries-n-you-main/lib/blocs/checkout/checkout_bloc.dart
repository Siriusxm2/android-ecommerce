import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceries_n_you/blocs/payment/payment_bloc.dart';
import 'package:groceries_n_you/models/payment_method_model.dart';

import '../../models/cart_model.dart';
import '../../models/checkout_model.dart';
import '../../models/product_model.dart';
import '../../repositories/checkout/checkout_repo.dart';
import '../cart/cart_bloc.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  final PaymentBloc _paymentBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _paymentSubscription;
  StreamSubscription? _checkoutSubscription;

  CheckoutBloc({
    required CartBloc cartBloc,
    required PaymentBloc paymentBloc,
    required CheckoutRepository checkoutRepository,
  })  : _checkoutRepository = checkoutRepository,
        _paymentBloc = paymentBloc,
        _cartBloc = cartBloc,
        super(
          cartBloc.state is CartLoaded
              ? CheckoutLoaded(
                  products: (cartBloc.state as CartLoaded).cart.products,
                  voucher: (cartBloc.state as CartLoaded).cart.voucher,
                  deliveryFee: (cartBloc.state as CartLoaded).cart.deliveryFee,
                  subtotal: (cartBloc.state as CartLoaded).cart.subtotal,
                  total: (cartBloc.state as CartLoaded).cart.totalDouble,
                )
              : CheckoutLoading(),
        ) {
    on<UpdateCheckout>(_onUpdateCheckout);
    on<ConfirmCheckout>(_onConfirmCheckout);

    _cartSubscription = cartBloc.stream.listen((state) {
      if (state is CartLoaded) add(UpdateCheckout(cart: state.cart));
    });

    _paymentSubscription = paymentBloc.stream.listen((state) {
      if (state is PaymentLoaded) {
        add(UpdateCheckout(paymentMethod: state.paymentMethodModel));
      }
    });
  }

  void _onUpdateCheckout(
    UpdateCheckout event,
    Emitter<CheckoutState> emit,
  ) {
    final state = this.state;
    if (state is CheckoutLoaded) {
      emit(
        CheckoutLoaded(
          name: event.name ?? state.name,
          email: event.email ?? state.email,
          address: event.address ?? state.address,
          phone: event.phone ?? state.phone,
          products: event.cart?.products ?? state.products,
          deliveryDate: event.deliveryDate ?? state.deliveryDate,
          deliveryTime: event.deliveryTime ?? state.deliveryTime,
          paymentMethod: event.paymentMethod ?? state.paymentMethod,
          subtotal: event.cart?.subtotal ?? state.subtotal,
          deliveryFee: event.cart?.deliveryFee ?? state.deliveryFee,
          voucher: event.cart?.voucher ?? state.voucher,
          total: event.cart?.totalDouble ?? state.total,
        ),
      );
    }
  }

  void _onConfirmCheckout(
    ConfirmCheckout event,
    Emitter<CheckoutState> emit,
  ) async {
    final state = this.state;
    _checkoutSubscription?.cancel();
    if (state is CheckoutLoaded) {
      try {
        await _checkoutRepository.addCheckout(event.checkout);
        print('Done');
        emit(CheckoutLoading());
      } catch (_) {}
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    _paymentSubscription?.cancel();
    return super.close();
  }
}
