import 'package:twitter_api/domain/entities/tweet.dart';
import 'package:twitter_api/domain/repositories/tweet_repository.dart';

class GetAllTweets {
  final TweetRepository tweetRepository;

  GetAllTweets(this.tweetRepository);

  Future<List<Tweet>> execute() async {
    return await tweetRepository.getAllTweets();
  }
}
