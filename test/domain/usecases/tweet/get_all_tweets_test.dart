import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_api/domain/repositories/tweet_repository.dart';
import 'package:twitter_api/domain/usecases/tweet/get_all_tweets.dart';
import 'get_all_tweets_test.mock.dart';

void main() {

  TweetRepository mockTweetRepository = MockTweetRepository();
  test('Deve retornar uma lista de tweets', () async {
    final result = await GetAllTweets(mockTweetRepository).execute();

    expect(result.length, greaterThanOrEqualTo(1));
  });
}
