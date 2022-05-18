import 'package:twitter_api/domain/entities/tweet.dart';
import 'package:twitter_api/domain/repositories/tweet_repository.dart';

class GetTweetById {
  final TweetRepository tweetRepository;

  GetTweetById(this.tweetRepository);

  Future<Tweet> execute(int id) async {
    return await tweetRepository.getTweetById(id);
  }
}
