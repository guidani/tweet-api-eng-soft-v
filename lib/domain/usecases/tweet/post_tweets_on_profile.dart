import 'package:twitter_api/domain/entities/tweet.dart';
import 'package:twitter_api/domain/repositories/tweet_repository.dart';

class PostTweetOnProfile {
  final TweetRepository tweetRepository;

  PostTweetOnProfile(this.tweetRepository);

  Future<void> execute(Tweet tweet) async {
    return await tweetRepository.postTweetOnProfile(tweet);
  }
}