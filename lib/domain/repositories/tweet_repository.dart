import 'package:twitter_api/domain/entities/tweet.dart';

abstract class TweetRepository {
  Future<List<Tweet>> getAllTweets();
  Future<Tweet> getTweetById(int id);
  Future<void>? postTweetOnProfile(Tweet tweet);
  Future<bool>? deleteTweet(int id);
  Future<void>? editTweet(int id);
  Future<void>? postTweetAsComment();
}
