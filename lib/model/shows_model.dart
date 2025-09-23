import 'package:seven/app/app.dart';

class ShowsModel {
  final Dates? dates;
  final int? page;
  final List<Result>? results;
  final int? totalPages;
  final int? totalResults;
  final Network? status;

  ShowsModel({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
    this.status,
  });

  factory ShowsModel.fromJson(Map<String, dynamic> json) => ShowsModel(
      dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
      page: json["page"],
      results: (json["results"] as List<dynamic>?)
          ?.map((x) => Result.fromJson(x as Map<String, dynamic>))
          .toList(),
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
      status: Network());

  Map<String, dynamic> toJson() => {
        "dates": dates?.toJson(),
        "page": page,
        "results":
            results != null ? results!.map((x) => x.toJson()).toList() : [],
        "total_pages": totalPages,
        "total_results": totalResults
      };
}

class Dates {
  final DateTime? maximum;
  final DateTime? minimum;

  Dates({this.maximum, this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum:
            json["maximum"] != null ? DateTime.parse(json["maximum"]) : null,
        minimum:
            json["minimum"] != null ? DateTime.parse(json["minimum"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "maximum": maximum != null ? dateFormat(maximum!) : null,
        "minimum": minimum != null ? dateFormat(minimum!) : null,
      };
}

class Result {
  final bool? adult;
  final String? backdropPath;
  final List<dynamic>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  Result(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreIds: json["genre_ids"]?.map((x) => x).toList(),
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"]?.toDouble(),
      posterPath: json["poster_path"],
      releaseDate: json["release_date"] != null
          ? DateTime.parse(json["release_date"])
          : null,
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"]?.toDouble(),
      voteCount: json["vote_count"]);

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": genreIds != null ? genreIds!.map((x) => x).toList() : [],
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate != null ? dateFormat(releaseDate!) : null,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount
      };
}

String dateFormat(DateTime time) {
  return "${time.year.toString().padLeft(4, '0')}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}";
}
