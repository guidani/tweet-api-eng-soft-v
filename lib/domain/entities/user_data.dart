import 'package:twitter_api/domain/entities/tweet.dart';

class UserData {
  UserData(
      {this.name,
      this.email,
      this.arroba,
      this.following,
      this.followers,
      this.tweets,
      this.saved_tweets});

  final String? name;
  final String? email;
  final String? arroba;
  final List<UserData>? following;
  final List<UserData>? followers;
  final List<Tweet>? tweets;
  final List<Tweet>? saved_tweets;
}
