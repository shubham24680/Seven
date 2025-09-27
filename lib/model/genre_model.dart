import 'package:seven/app/app.dart';

class GenreModel extends Network<GenreModel> {
  final List<Genre>? genres;

  GenreModel({
    this.genres,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        genres: (json["genres"] as List<dynamic>?)
            ?.map((x) => Genre.fromJson(x))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "genres": genres != null ? genres!.map((x) => x.toJson()).toList() : [],
      };
}

class Genre {
  final int? id;
  final String? name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
