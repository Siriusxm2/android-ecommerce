import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';
import 'base_user_repo.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<UserModel> getUser(String userId) {
    print('Getting user data from Cloud Firestore');
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) => UserModel.fromSnapshot(snap));
  }

  @override
  Future<void> createUser(UserModel user) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .set(user.toDocument());
  }

  @override
  Future<void> updateUser(UserModel user) async {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toDocument())
        .then((value) => print('User document updated.'));
  }
}
