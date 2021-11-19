import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/bloc/watchlist_series_bloc_cubit.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_series_bloc_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchlistSeries,
])
void main() {
  late WatchlistSeriesBlocCubit watchlistSeriesBlocCubit;
  late MockGetWatchlistSeries mockGetWatchlistSeries;

  setUp(() {
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    watchlistSeriesBlocCubit = WatchlistSeriesBlocCubit(
      mockGetWatchlistSeries,
    );
  });

  final tSeries = Series(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
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

  final tSeriesList = <Series>[tSeries];

  group('Get Watchlist Series', () {
    test('should be initial state', () {
      expect(watchlistSeriesBlocCubit.state, WatchlistSeriesState.initialState());
    });

    blocTest<WatchlistSeriesBlocCubit, WatchlistSeriesState>(
      'Should emit [watchlistLoading, watchlistSeries] data when data is gotten successfully',
      build: () {
        when(mockGetWatchlistSeries.execute()).thenAnswer((_) async => Right(tSeriesList));
        return watchlistSeriesBlocCubit;
      },
      act: (bloc) => bloc.fetchWatchlistSeries(),
      expect: () => [
        WatchlistSeriesState(
          message: null,
          watchlistLoading: true,
          watchlistSeries: null,
        ),
        WatchlistSeriesState(
          message: null,
          watchlistLoading: false,
          watchlistSeries: tSeriesList,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistSeries.execute());
      },
    );

    blocTest<WatchlistSeriesBlocCubit, WatchlistSeriesState>(
      'Should emit [popularLoading, message error] data when data is unsuccessfully',
      build: () {
        when(mockGetWatchlistSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistSeriesBlocCubit;
      },
      act: (bloc) => bloc.fetchWatchlistSeries(),
      expect: () => [
        WatchlistSeriesState(
          message: null,
          watchlistLoading: true,
          watchlistSeries: null,
        ),
        WatchlistSeriesState(
          message: 'Server Failure',
          watchlistLoading: false,
          watchlistSeries: null,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistSeries.execute());
      },
    );
  });
}
