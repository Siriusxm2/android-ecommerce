part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class LoadPaymentMethod extends PaymentEvent {}

class SelectPaymentMethod extends PaymentEvent {
  final PaymentMethodModel paymentMethodModel;

  const SelectPaymentMethod({required this.paymentMethodModel});

  @override
  List<Object> get props => [paymentMethodModel];
}
