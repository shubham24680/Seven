class Item {
  final String imageUrl, title, summary, premiered, language, status, type;
  final dynamic rating, runtime;
  final List<dynamic> genres;

  Item({
    required this.imageUrl,
    required this.title,
    required this.summary,
    required this.premiered,
    required this.rating,
    required this.genres,
    required this.runtime,
    required this.language,
    required this.status,
    required this.type,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    final show = json["show"];
    if (show == null) {
      throw Exception("Missing 'show' field in JSON entry");
    }
    return Item(
      title: show["name"] ?? "...",
      type: show["type"] ?? "...",
      language: show["language"] ?? "...",
      genres: show["genres"] ?? [],
      status: show["status"] ?? "...",
      runtime: show["runtime"] ?? 0,
      premiered: show["premiered"] ?? "2024-01-01",
      rating: show["rating"] != null ? show["rating"]["average"] ?? 0 : 0,
      imageUrl: show["image"] != null
          ? show["image"]["medium"] ??
              "https://m.media-amazon.com/images/M/MV5BYTIwYzk3YmQtZmMwNS00ZDAwLTk5Y2MtOTEwODFlZmExMzliXkEyXkFqcGc@"
          : "https://m.media-amazon.com/images/M/MV5BYTIwYzk3YmQtZmMwNS00ZDAwLTk5Y2MtOTEwODFlZmExMzliXkEyXkFqcGc@",
      summary: (show["summary"] ?? "No summary available"),
    );
  }
}
