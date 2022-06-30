import 'package:twitter_api/domain/entities/user_data.dart';

abstract class UserDataRepository {
  Future<List<UserData>> getAllUsers();
  Future<UserData> getUserById(int id);
  Future<bool>? deleteUser(int id);
  Future<void>? editUser(int id);
}
