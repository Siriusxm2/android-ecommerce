part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCheckout extends CheckoutEvent {
  final String? name;
  final String? email;
  final String? address;
  final String? phone;
  final String? deliveryDate;
  final String? deliveryTime;
  final String? paymentMethod;
  final CartModel? cart;

  const UpdateCheckout({
    this.name,
    this.email,
    this.address,
    this.phone,
    this.deliveryDate,
    this.deliveryTime,
    this.paymentMethod,
    this.cart,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        address,
        phone,
        deliveryDate,
        deliveryTime,
        paymentMethod,
        cart,
      ];
}

class ConfirmCheckout extends CheckoutEvent {
  final CheckoutModel checkout;

  const ConfirmCheckout({required this.checkout});

  @override
  List<Object?> get props => [checkout];
}
