class Tweet {
  final int id;
  final int? ref_id;
  final int user_id;
  final String content;
  final List<Tweet>? comments;
  final int? qtd_retweets;
  final int? qtd_likes;

  Tweet(
      {required this.id,
      required this.ref_id,
      required this.user_id,
      required this.content,
      required this.comments,
      required this.qtd_retweets,
      required this.qtd_likes});
}
