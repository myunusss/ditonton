import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = SeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist series', () {
    test('should return success message when insert to database series is success', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistSeries(testSeriesTable)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlistSeries(testSeriesTable);
      // assert
      expect(result, 'Added to Watchlist Series');
    });

    test('should throw DatabaseException when insert to database series is failed', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistSeries(testSeriesTable)).thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlistSeries(testSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist series', () {
    test('should return success message when remove from database series is success', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistSeries(testSeriesTable)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlistSeries(testSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist Series');
    });

    test('should throw DatabaseException when remove from database is failed', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistSeries(testSeriesTable)).thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlistSeries(testSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Series Detail By Id', () {
    final tId = 1;

    test('should return Series Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getSeriesById(tId)).thenAnswer((_) async => testSeriesMap);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, testSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getSeriesById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist series', () {
    test('should return list of SeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistSeries()).thenAnswer((_) async => [testSeriesMap]);
      // act
      final result = await dataSource.getWatchlistSeries();
      // assert
      expect(result, [testSeriesTable]);
    });
  });
}
