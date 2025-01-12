class Item {
  final String? imageUrl, title, summary;

  Item({
    required this.imageUrl,
    required this.title,
    required this.summary,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    final show = json["show"];
    if (show == null) {
      throw Exception("Missing 'show' field in JSON entry");
    }
    return Item(
      imageUrl: show["image"] != null
          ? show["image"]["medium"] ??
              "https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FMandalorian_%2528character%2529&psig=AOvVaw1X5L0aobRngShamEr-Cfgd&ust=1736793004954000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIjdhqLo8IoDFQAAAAAdAAAAABAJ"
          : "https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FMandalorian_%2528character%2529&psig=AOvVaw1X5L0aobRngShamEr-Cfgd&ust=1736793004954000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIjdhqLo8IoDFQAAAAAdAAAAABAJ",
      title: show["name"],
      summary: (show["summary"] ?? "No summary available"),
    );
  }
}
