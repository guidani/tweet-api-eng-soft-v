import 'package:twitter_api/domain/entities/tweet.dart';
import 'package:twitter_api/domain/entities/user_data.dart';
import 'package:twitter_api/domain/repositories/user_repository.dart';

class GetAllUsers {
  final UserDataRepository userRepository;

  GetAllUsers(this.userRepository);

  Future<List<UserData>> execute() async {
    return await userRepository.getAllUsers();
  }
}
