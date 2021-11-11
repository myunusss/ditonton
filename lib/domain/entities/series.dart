import 'package:equatable/equatable.dart';

class Series extends Equatable {
  Series({
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

  Series.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
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
