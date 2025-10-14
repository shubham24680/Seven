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
