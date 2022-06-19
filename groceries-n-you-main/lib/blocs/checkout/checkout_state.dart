part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutLoading extends CheckoutState {
  @override
  List<Object> get props => [];
}

class CheckoutLoaded extends CheckoutState {
  final String? name;
  final String? email;
  final String? address;
  final String? phone;
  final List<ProductModel>? products;
  final String? deliveryDate;
  final String? deliveryTime;
  final PaymentMethodModel? paymentMethod;
  final num? subtotal;
  final num? deliveryFee;
  final num? voucher;
  final num? total;
  final CheckoutModel checkout;

  CheckoutLoaded({
    this.name,
    this.email,
    this.address,
    this.phone,
    this.products,
    this.deliveryDate,
    this.deliveryTime,
    this.paymentMethod,
    this.subtotal,
    this.deliveryFee,
    this.voucher,
    this.total,
  }) : checkout = CheckoutModel(
          name: name,
          email: email,
          address: address,
          phone: phone,
          products: products,
          deliveryDate: deliveryDate,
          deliveryTime: deliveryTime,
          paymentMethod: paymentMethod,
          subtotal: subtotal,
          deliveryFee: deliveryFee,
          voucher: voucher,
          total: total,
        );

  @override
  List<Object?> get props => [
        name,
        email,
        address,
        phone,
        products,
        deliveryDate,
        deliveryTime,
        paymentMethod,
        subtotal,
        deliveryFee,
        voucher,
        total,
      ];
}
