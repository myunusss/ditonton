import 'package:ditonton/domain/entities/series.dart';
import 'package:equatable/equatable.dart';

class SeriesModel extends Equatable {
  SeriesModel({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.name,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
  });

  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? originalName;
  String? name;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  double? voteAverage;
  int? voteCount;

  factory SeriesModel.fromJson(Map<String, dynamic> json) => SeriesModel(
        name: json["name"],
        firstAirDate: json["first_air_date"],
        originalName: json["original_name"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "first_air_date": firstAirDate,
        "name": name,
        "original_name": originalName
      };

  Series toEntity() {
    return Series(
      name: this.name,
      firstAirDate: this.firstAirDate,
      originalName: this.originalName,
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        originalName,
        name,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        voteAverage,
        voteCount,
      ];
}
