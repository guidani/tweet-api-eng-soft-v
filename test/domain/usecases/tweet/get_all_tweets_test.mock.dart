import 'package:twitter_api/domain/entities/tweet.dart';
import 'package:twitter_api/domain/repositories/tweet_repository.dart';

class MockTweetRepository implements TweetRepository {
  final fakeTweet = [
    Tweet(
        id: 1,
        ref_id: 12,
        user_id: 1233,
        content: 'content',
        comments: [],
        qtd_retweets: 0,
        qtd_likes: 0)
  ];
  @override
  Future<bool>? deleteTweet(int id) async {
    fakeTweet.removeWhere((element) => element.id == id);
    // if(fakeTweet.contains())
    return true;
  }

  @override
  Future<void>? editTweet(int id) async {}

  @override
  Future<List<Tweet>> getAllTweets() async {
    return fakeTweet;
  }

  @override
  Future<void>? postTweetAsComment() async {}

  @override
  Future<void>? postTweetOnProfile(Tweet tweet) async {
    fakeTweet.add(tweet);
  }

  @override
  Future<Tweet> getTweetById(int id) async {
    Tweet oneTweet = fakeTweet[0];
    return oneTweet;
  }
}
