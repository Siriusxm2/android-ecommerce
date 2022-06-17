import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/product_model.dart';
import '../../repositories/product/product_repo.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<UpdateProducts>(_onUpdateProducts);
  }

  void _onLoadProducts(event, Emitter<ProductState> emit) {
    _productSubscription?.cancel();
    _productSubscription = _productRepository.getAllProducts().listen(
          (products) => add(
            UpdateProducts(products),
          ),
        );
  }

  void _onUpdateProducts(event, Emitter<ProductState> emit) async {
    emit(ProductLoaded(products: event.products));
  }
}
