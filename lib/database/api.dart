
class Show {
  final int malId;
  final int episodes;
  final String title;
  final String imageUrl;
  final double score;

  Show({
    required this.malId,
    required this.episodes,
    required this.title,
    required this.imageUrl,
    required this.score,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['image_url'],
      score: json['score'],
      episodes: json['episodes']
    );
  }

}
