class Item {
  final String imageUrl, title, summary;

  Item({
    required this.imageUrl,
    required this.title,
    required this.summary,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    final show = json['show'];
    if (show == null) {
      throw Exception("Missing 'show' field in JSON entry");
    }
    return Item(
      imageUrl: show['image']?['original'] ?? '',
      title: show['name'],
      summary: (show['summary'] ?? 'No summary available').replaceAll(
        RegExp(r'<[^>]*>'),
      ),
    );
  }
}
