class Cast {
  List<Actor> actores = <Actor>[];

  Cast();

  Cast.fromJsonList(List<dynamic> jsonList) {

    if (jsonList == null) return;

    for (var item in jsonList) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    }
  }
}

class Actor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int castId;
  String character;
  String creditId;
  int order;


  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
     this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order
  });

  Actor.fromJsonMap(Map<String, dynamic> json)
      : adult = json['adult'],
        gender = json['gender'],
        id = json['id'],
        knownForDepartment = json['known_for_department'],
        name = json['name'],
        originalName = json['original_name'],
        popularity = json['popularity'],
        profilePath = json['profile_path'],
        castId = json['cast_id'],
        character = json['character'],
        creditId = json['credit_id'],
        order = json['order'];

  getFoto() {
    if (profilePath == null) {
      return 'https://media.istockphoto.com/vectors/profile-placeholder-image-gray-silhouette-no-photo-vector-id1016744004?k=20&m=1016744004&s=612x612&w=0&h=Z4W8y-2T0W-mQM-Sxt41CGS16bByUo4efOIJuyNBHgI=';
    }
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}
