class Credits {
  final int? id;
  final List<CastAndCrew>? cast;
  final List<CastAndCrew>? crew;

  Credits({this.id, this.cast, this.crew});

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
      id: json["id"],
      cast: (json["cast"] as List<dynamic>?)
          ?.map((x) => CastAndCrew.fromJson(x as Map<String, dynamic>))
          .toList(),
      crew: (json["crew"] as List<dynamic>?)
          ?.map((x) => CastAndCrew.fromJson(x as Map<String, dynamic>))
          .toList());

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": cast?.map((x) => x.toJson()).toList(),
        "crew": crew?.map((x) => x.toJson()).toList()
      };
}

class CastAndCrew {
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
  final String? department;
  final String? job;

  CastAndCrew(
      {this.adult,
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
      this.department,
      this.job});

  factory CastAndCrew.fromJson(Map<String, dynamic> json) => CastAndCrew(
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
      order: json["order"],
      department: json["department"],
      job: json["job"]);

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
        "order": order,
        "department": department,
        "job": job
      };
}
