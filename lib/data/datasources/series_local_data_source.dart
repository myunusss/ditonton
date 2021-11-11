import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/series_table.dart';

abstract class SeriesLocalDataSource {
  Future<String> insertWatchlistSeries(SeriesTable series);
  Future<String> removeWatchlistSeries(SeriesTable series);
  Future<SeriesTable?> getSeriesById(int id);
  Future<List<SeriesTable>> getWatchlistSeries();
}

class SeriesLocalDataSourceImpl implements SeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  SeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistSeries(SeriesTable series) async {
    try {
      await databaseHelper.insertWatchlistSeries(series);
      return 'Added to Watchlist Series';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistSeries(SeriesTable series) async {
    try {
      await databaseHelper.removeWatchlistSeries(series);
      return 'Removed from Watchlist Series';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<SeriesTable?> getSeriesById(int id) async {
    final result = await databaseHelper.getSeriesById(id);
    if (result != null) {
      return SeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<SeriesTable>> getWatchlistSeries() async {
    final result = await databaseHelper.getWatchlistSeries();
    return result.map((data) => SeriesTable.fromMap(data)).toList();
  }
}
