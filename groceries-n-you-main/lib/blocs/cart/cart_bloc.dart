import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceries_n_you/models/cart_model.dart';
import 'package:groceries_n_you/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<ResetCart>(_onResetCart);
  }

  void _onLoadCart(event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      emit(const CartLoaded());
    } catch (_) {
      emit(CartError());
    }
  }

  void _onAddProduct(event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(CartLoaded(
          cart: CartModel(products: List.from(state.cart.products)..add(event.product)),
        ));
      } catch (_) {
        emit(CartError());
      }
    }
  }

  void _onRemoveProduct(event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(CartLoaded(
          cart: CartModel(products: List.from(state.cart.products)..remove(event.product)),
        ));
      } catch (_) {
        emit(CartError());
      }
    }
  }

  void _onResetCart(event, Emitter<CartState> emit) {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        for (int i = 0; i < state.cart.products.length; i++) {
          emit(CartLoaded(cart: CartModel(products: List.from(state.cart.products)..remove(event.product[i]))));
        }
      } catch (_) {
        emit(CartError());
      }
    }
  }
}
