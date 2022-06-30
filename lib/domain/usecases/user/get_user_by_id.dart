import 'package:twitter_api/domain/entities/tweet.dart';
import 'package:twitter_api/domain/entities/user_data.dart';
import 'package:twitter_api/domain/repositories/user_repository.dart';

class GetUserById {
  final UserDataRepository userRepository;

  GetUserById(this.userRepository);

  Future<UserData> execute(int id) async {
    return await userRepository.getUserById(id);
  }
}
