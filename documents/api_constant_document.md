``` Dart
class ApiConstants {
  static const String API_KEY = "YOUR_API_KEY_HERE";
  static const String BEARER_TOKEN = "Bearer YOUR_BEARER_TOKEN_HERE";

  static const String BASE_URL = "https://api.themoviedb.org/";
  static const String VERSION_3 = "3/";
  static const String IMAGE_PATH = "https://image.tmdb.org/t/p/";
  static const String PIXEL_500 = "w500";

  static const Duration CONNECTION_TIMEOUT = Duration(seconds: 30);
  static const String DEFAULT_LANGUAGE = 'en-US';

  static const String TRENDING = "trending/all/day";
  static const String TRENDING_MOVIES = "trending/movie/day";
  static const String TRENDING_TV = "trending/tv/day";

  static const String MOVIES = "discover/movie";
  static const String TV = "discover/tv";
  static const String MOVIE_DETAIL = "movie/";
  static const String COLLECTION_DETAIL = "collection/";
  static const String CREDITS = "/credits";

  static const String SEARCH = "search/movie";
  static const String GENRES = "genre/movie/list";
}

class SortBy {
  static const String VOTE_AVERAGE_DESC = "vote_average.desc";
  static const String VOTE_AVERAGE_ASC = "vote_average.asc";
  static const String POPULARITY_DESC = "popularity.desc";
  static const String POPULARITY_ASC = "popularity.asc";
  static const String PRIMARY_RELEASE_DATE_DESC = "primary_release_date.desc";
  static const String PRIMARY_RELEASE_DATE_ASC = "primary_release_date.asc";
}

class Region {
  static const String INDIA = "IN";
  static const String USA = "US";
}

class OriginalLanguage {
  static const String INDIA = "hi";
  static const String USA = "en";
}