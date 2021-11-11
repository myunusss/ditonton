import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:equatable/equatable.dart';

class SeriesDetailResponse extends Equatable {
  SeriesDetailResponse({
    required this.backdropPath,
    required this.genres,
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
  final List<GenreModel> genres;
  int id;
  String? originalName;
  String? name;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  double? voteAverage;
  int? voteCount;

  factory SeriesDetailResponse.fromJson(Map<String, dynamic> json) => SeriesDetailResponse(
        name: json["name"],
        firstAirDate: json["first_air_date"],
        originalName: json["original_name"],
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  SeriesDetail toEntity() {
    return SeriesDetail(
      name: this.name,
      firstAirDate: this.firstAirDate,
      originalName: this.originalName,
      backdropPath: this.backdropPath,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
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
        genres,
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
