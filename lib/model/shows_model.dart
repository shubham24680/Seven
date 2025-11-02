import 'package:seven/app/app.dart';

class ShowsModel extends Network<ShowsModel> {
  final Dates? dates;
  final int? page;
  final List<Result>? results;
  final int? totalPages;
  final int? totalResults;

  ShowsModel({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory ShowsModel.fromJson(Map<String, dynamic> json) => ShowsModel(
      dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
      page: json["page"],
      results: (json["results"] as List<dynamic>?)
          ?.map((x) => Result.fromJson(x as Map<String, dynamic>))
          .toList(),
      totalPages: json["total_pages"],
      totalResults: json["total_results"]);

  Map<String, dynamic> toJson() => {
        "dates": dates?.toJson(),
        "page": page,
        "results": results?.map((x) => x.toJson()).toList(),
        "total_pages": totalPages,
        "total_results": totalResults
      };
}

class Dates {
  final DateTime? maximum;
  final DateTime? minimum;

  Dates({this.maximum, this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: _parseDateTime(json["maximum"]),
        minimum: _parseDateTime(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum": maximum != null ? dateFormat(maximum!) : null,
        "minimum": minimum != null ? dateFormat(minimum!) : null,
      };
}

class Result extends Network<Result> {
  final bool? adult;
  final String? backdropPath;
  final Result? belongsToCollection;
  final int? budget;
  final List<Genre>? genres;
  final List<dynamic>? genreIds;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final String? originalLanguage;
  final String? originalTitle;
  final String? originalName;
  final String? overview;
  final List<Result>? parts;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final DateTime? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final String? voteAverage;
  final int? voteCount;
  final String? mediaType;
  final String? name;

  Result(
      {this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.genreIds,
      this.homepage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.originalName,
      this.overview,
      this.parts,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.mediaType,
      this.name});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreIds: (json["genre_ids"] as List<dynamic>?)?.cast<int>(),
      belongsToCollection: json["belongs_to_collection"] != null
          ? Result.fromJson(
              json["belongs_to_collection"] as Map<String, dynamic>)
          : null,
      budget: json["budget"],
      genres: (json["genres"] as List<dynamic>?)
          ?.map((x) => Genre.fromJson(x as Map<String, dynamic>))
          .toList(),
      homepage: json["homepage"],
      id: json["id"],
      imdbId: json["imdb_id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      originalName: json["original_name"],
      overview: json["overview"],
      parts: (json["parts"] as List<dynamic>?)
          ?.map((x) => Result.fromJson(x as Map<String, dynamic>))
          .toList(),
      popularity: json["popularity"]?.toDouble(),
      posterPath: json["poster_path"],
      productionCompanies: (json["production_companies"] as List<dynamic>?)
          ?.map((x) => ProductionCompany.fromJson(x as Map<String, dynamic>))
          .toList(),
      productionCountries: (json["production_countries"] as List<dynamic>?)
          ?.map((x) => ProductionCountry.fromJson(x as Map<String, dynamic>))
          .toList(),
      releaseDate: _parseDateTime(json["release_date"]),
      revenue: json["revenue"],
      runtime: json["runtime"],
      spokenLanguages: (json["spoken_languages"] as List<dynamic>?)
          ?.map((x) => SpokenLanguage.fromJson(x as Map<String, dynamic>))
          .toList(),
      status: json["status"],
      tagline: json["tagline"],
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"]?.toStringAsFixed(1),
      voteCount: json["vote_count"],
      mediaType: json["media_type"],
      name: json["name"]);

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": genreIds,
        "belongs_to_collection": belongsToCollection,
        "budget": budget,
        "genres": genres?.map((x) => x.toJson()).toList(),
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "original_name": originalName,
        "overview": overview,
        "parts": parts?.map((x) => x.toJson()),
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies":
            productionCompanies?.map((x) => x.toJson()).toList(),
        "production_countries":
            productionCountries?.map((x) => x.toJson()).toList(),
        "release_date": dateFormat(releaseDate),
        "revenue": revenue,
        "runtime": runtime,
        "spoken_languages": spokenLanguages?.map((x) => x.toJson()).toList(),
        "status": status,
        "tagline": tagline,
        "title": title,
        "video": video,
        "vote_average": double.parse(voteAverage ?? "0.0"),
        "vote_count": voteCount,
        "media_type": mediaType,
        "name": name
      };
}

class Genre {
  final int? id;
  final String? name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json["id"] as int?, name: json["name"] as String?);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class ProductionCompany {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  ProductionCompany({this.id, this.logoPath, this.name, this.originCountry});

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
          id: json["id"] as int?,
          logoPath: json["logo_path"] as String?,
          name: json["name"] as String?,
          originCountry: json["origin_country"] as String?);

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry
      };
}

class ProductionCountry {
  final String? iso31661;
  final String? name;

  ProductionCountry({this.iso31661, this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
          iso31661: json["iso_3166_1"] as String?,
          name: json["name"] as String?);

  Map<String, dynamic> toJson() => {"iso_3166_1": iso31661, "name": name};
}

class SpokenLanguage {
  final String? englishName;
  final String? iso6391;
  final String? name;

  SpokenLanguage({this.englishName, this.iso6391, this.name});

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
      englishName: json["english_name"] as String?,
      iso6391: json["iso_639_1"] as String?,
      name: json["name"] as String?);

  Map<String, dynamic> toJson() =>
      {"english_name": englishName, "iso_639_1": iso6391, "name": name};
}

/// Safely parses a date string to DateTime
DateTime? _parseDateTime(dynamic dateString) {
  if (dateString == null || dateString is! String) return null;
  try {
    return DateTime.parse(dateString);
  } catch (e) {
    return null;
  }
}

/// Formats DateTime to ISO date string
String? dateFormat(DateTime? time) {
  if (time == null) return null;
  return "${time.year.toString().padLeft(4, '0')}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}";
}
