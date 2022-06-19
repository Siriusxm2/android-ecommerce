import 'package:groceries_n_you/models/user_model.dart';

abstract class BaseUserRepository {
  Stream<UserModel> getUser(String userId);
  Future<void> createUser(UserModel user);
  Future<void> updateUser(UserModel user);
}
