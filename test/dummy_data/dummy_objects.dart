// SERIES
import 'package:ditonton/data/models/series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';

final testSeriesTable = SeriesTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testSeriesDetail = SeriesDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
  firstAirDate: '2011-04-17',
  name: 'title',
  originalName: 'title',
);

final testSeries = Series(
  backdropPath: 'backdropPath',
  genreIds: [1, 2, 3],
  id: 1,
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
  firstAirDate: '2011-04-17',
  name: 'Name of series',
  originalName: 'Name of series',
);

final testSeriesList = [testSeries];

final testWatchlistSeries = Series.watchlist(
  name: 'title',
  id: 1,
  posterPath: 'posterPath',
  overview: 'overview',
);
