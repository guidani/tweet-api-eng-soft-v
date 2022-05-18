import 'package:twitter_api/domain/entities/tweet.dart';

class User {
  final int id;
  final String name;
  final String arroba;
  final List<User>? following;
  final List<User>? followers;
  final List<Tweet> tweets;
  final List<Tweet> saved_tweets;

  User(this.id, this.name, this.arroba, this.following, this.followers,
      this.tweets, this.saved_tweets);
}
