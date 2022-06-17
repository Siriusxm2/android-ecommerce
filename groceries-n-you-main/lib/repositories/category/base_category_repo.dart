import 'package:groceries_n_you/models/category_model.dart';

abstract class BaseCategoryRepository {
  Stream<List<CategoryModel>> getAllCategories();
}
