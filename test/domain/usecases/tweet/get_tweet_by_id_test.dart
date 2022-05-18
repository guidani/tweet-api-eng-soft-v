import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_api/domain/repositories/tweet_repository.dart';
import 'package:twitter_api/domain/usecases/tweet/get_tweet_by_id.dart';

import 'get_all_tweets_test.mock.dart';

void main() {
  TweetRepository mockTweetRepository = MockTweetRepository();
  test('Deve retornar um tweet de acordo com o id', () async {
    final int id = 1;
    final result = await GetTweetById(mockTweetRepository).execute(id);
    expect(result.id, id);
  });
}
