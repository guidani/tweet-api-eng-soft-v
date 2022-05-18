import 'package:twitter_api/domain/repositories/tweet_repository.dart';

class DeleteTweet {
  final TweetRepository tweetRepository;

  DeleteTweet(this.tweetRepository);

  Future<bool>? execute(int id) async {
    bool? res = await tweetRepository.deleteTweet(id);
    if (!res!) {
      return false;
    }
    return true;
  }
}
