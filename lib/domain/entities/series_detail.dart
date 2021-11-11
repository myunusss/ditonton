import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class SeriesDetail extends Equatable {
  SeriesDetail({
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
  final List<Genre> genres;
  int id;
  String? originalName;
  String? name;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  double? voteAverage;
  int? voteCount;

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
