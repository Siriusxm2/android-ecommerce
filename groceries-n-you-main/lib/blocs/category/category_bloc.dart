import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceries_n_you/models/category_model.dart';
import 'package:groceries_n_you/repositories/category/category_repo.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  StreamSubscription? _categorySubscription;

  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryLoading()) {
    on<LoadCategories>(_onLoadCategories);
    on<UpdateCategories>(_onUpdateCategories);
  }

  void _onLoadCategories(event, Emitter<CategoryState> emit) {
    _categorySubscription?.cancel();
    _categorySubscription = _categoryRepository.getAllCategories().listen(
          (categories) => add(
            UpdateCategories(categories),
          ),
        );
  }

  void _onUpdateCategories(event, Emitter<CategoryState> emit) async {
    emit(CategoryLoaded(categories: event.categories));
  }
}
