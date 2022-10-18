class Peliculas {
  List<Pelicula> items = <Pelicula>[];

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {
  String? uniqueId;
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Pelicula({
    this.uniqueId,
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json)
      : voteCount = json['vote_count'],
        id = json['id'],
        video = json['video'],
        voteAverage = json['vote_average'] / 1,
        title = json['title'],
        popularity = json['popularity'] / 1,
        posterPath = json['poster_path'],
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        genreIds = json['genre_ids'].cast<int>(),
        backdropPath = json['backdrop_path'],
        adult = json['adult'],
        overview = json['overview'],
        releaseDate = json['release_date'];

  getPosterImg() {
    if (posterPath == null) {
      return 'https://i.stack.imgur.com/mwFzF.png';
    }
    return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }

  getBackgroundImg() {
    if (backdropPath == null) {
      return 'https://i.stack.imgur.com/mwFzF.png';
    }
    return 'https://image.tmdb.org/t/p/w500/$backdropPath';
  }
}
