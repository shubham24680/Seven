class Credits {
  final int? id;
  final List<Cast>? cast;

  Credits({
    this.id,
    this.cast,
  });

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
      id: json["id"],
      cast: json["cast"] == null
          ? []
          : (json["cast"] as List<dynamic>?)
              ?.map((x) => Cast.fromJson(x as Map<String, dynamic>))
              .toList());

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": cast == null ? [] : cast?.map((x) => x.toJson()).toList()
      };
}

class Cast {
  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String? creditId;
  final int? order;

  Cast({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
      adult: json["adult"],
      gender: json["gender"],
      id: json["id"],
      knownForDepartment: json["known_for_department"],
      name: json["name"],
      originalName: json["original_name"],
      popularity: json["popularity"]?.toDouble(),
      profilePath: json["profile_path"],
      castId: json["cast_id"],
      character: json["character"],
      creditId: json["credit_id"],
      order: json["order"]);

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order
      };
}
