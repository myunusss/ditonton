import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/bloc/series_list_bloc_cubit.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'series_list_bloc_cubit_test.mocks.dart';

@GenerateMocks([
  GetTopRatedSeries,
  GetNowPlayingSeries,
  GetPopularSeries,
])
void main() {
  late SeriesListBlocCubit seriesListBlocCubit;
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;
  late MockGetPopularSeries mockGetPopularSeries;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    mockGetPopularSeries = MockGetPopularSeries();
    seriesListBlocCubit = SeriesListBlocCubit(
      mockGetPopularSeries,
      mockGetNowPlayingSeries,
      mockGetTopRatedSeries,
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

  group('Get Popular Series', () {
    test('should be initial state', () {
      expect(seriesListBlocCubit.state, SeriesListState.initialState());
    });

    blocTest<SeriesListBlocCubit, SeriesListState>(
      'Should emit [popularLoading, popularSeries] data when data is gotten successfully',
      build: () {
        when(mockGetPopularSeries.execute()).thenAnswer((_) async => Right(tSeriesList));
        return seriesListBlocCubit;
      },
      act: (bloc) => bloc.fetchPopularSeries(),
      expect: () => [
        SeriesListState(
          nowPlayingLoading: false,
          nowPlayingSeries: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedSeries: null,
          topRatedMessage: null,
          popularLoading: true,
          popularSeries: null,
          popularMessage: null,
        ),
        SeriesListState(
          nowPlayingLoading: false,
          nowPlayingSeries: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedSeries: null,
          topRatedMessage: null,
          popularLoading: false,
          popularSeries: tSeriesList,
          popularMessage: null,
        )
      ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      },
    );

    blocTest<SeriesListBlocCubit, SeriesListState>(
      'Should emit [popularLoading, popularMessage] data when unsuccessful',
      build: () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return seriesListBlocCubit;
      },
      act: (bloc) => bloc.fetchPopularSeries(),
      expect: () => [
        SeriesListState(
          nowPlayingLoading: false,
          nowPlayingSeries: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedSeries: null,
          topRatedMessage: null,
          popularLoading: true,
          popularSeries: null,
          popularMessage: null,
        ),
        SeriesListState(
          nowPlayingLoading: false,
          nowPlayingSeries: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedSeries: null,
          topRatedMessage: null,
          popularLoading: false,
          popularSeries: null,
          popularMessage: 'Server Failure',
        )
      ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      },
    );
  });

  group('Get Top Rated Series', () {
    test('should be initial state', () {
      expect(seriesListBlocCubit.state, SeriesListState.initialState());
    });

    blocTest<SeriesListBlocCubit, SeriesListState>(
      'Should emit [topRatedLoading, topRatedSeries] data when data is gotten successfully',
      build: () {
        when(mockGetTopRatedSeries.execute()).thenAnswer((_) async => Right(tSeriesList));
        return seriesListBlocCubit;
      },
      act: (bloc) => bloc.fetchTopRatedSeries(),
      expect: () => [
        SeriesListState(
          nowPlayingLoading: false,
          nowPlayingSeries: null,
          nowPlayingMessage: null,
          topRatedLoading: true,
          topRatedSeries: null,
          topRatedMessage: null,
          popularLoading: false,
          popularSeries: null,
          popularMessage: null,
        ),
        SeriesListState(
          nowPlayingLoading: false,
          nowPlayingSeries: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedSeries: tSeriesList,
          topRatedMessage: null,
          popularLoading: false,
          popularSeries: null,
          popularMessage: null,
        )
      ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      },
    );

    blocTest<SeriesListBlocCubit, SeriesListState>(
      'Should emit [topRatedLoading, topRatedMessage] data when unsuccessful',
      build: () {
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return seriesListBlocCubit;
      },
      act: (bloc) => bloc.fetchTopRatedSeries(),
      expect: () => [
        SeriesListState(
          nowPlayingLoading: false,
          nowPlayingSeries: null,
          nowPlayingMessage: null,
          topRatedLoading: true,
          topRatedSeries: null,
          topRatedMessage: null,
          popularLoading: false,
          popularSeries: null,
          popularMessage: null,
        ),
        SeriesListState(
          nowPlayingLoading: false,
          nowPlayingSeries: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedSeries: null,
          topRatedMessage: 'Server Failure',
          popularLoading: false,
          popularSeries: null,
          popularMessage: null,
        )
      ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      },
    );
  });

  group('Get Now Playing Series', () {
    test('should be initial state', () {
      expect(seriesListBlocCubit.state, SeriesListState.initialState());
    });

    blocTest<SeriesListBlocCubit, SeriesListState>(
      'Should emit [nowPlayingLoading, nowPlayingSeries] data when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingSeries.execute()).thenAnswer((_) async => Right(tSeriesList));
        return seriesListBlocCubit;
      },
      act: (bloc) => bloc.fetchNowPlayingSeries(),
      expect: () => [
        SeriesListState(
          nowPlayingLoading: true,
          nowPlayingSeries: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedSeries: null,
          topRatedMessage: null,
          popularLoading: false,
          popularSeries: null,
          popularMessage: null,
        ),
        SeriesListState(
          nowPlayingLoading: false,
          nowPlayingSeries: tSeriesList,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedSeries: null,
          topRatedMessage: null,
          popularLoading: false,
          popularSeries: null,
          popularMessage: null,
        )
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingSeries.execute());
      },
    );

    blocTest<SeriesListBlocCubit, SeriesListState>(
      'Should emit [nowPlayingLoading, nowPlayingMessage] data when unsuccessful',
      build: () {
        when(mockGetNowPlayingSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return seriesListBlocCubit;
      },
      act: (bloc) => bloc.fetchNowPlayingSeries(),
      expect: () => [
        SeriesListState(
          nowPlayingLoading: true,
          nowPlayingSeries: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedSeries: null,
          topRatedMessage: null,
          popularLoading: false,
          popularSeries: null,
          popularMessage: null,
        ),
        SeriesListState(
          nowPlayingLoading: false,
          nowPlayingSeries: null,
          nowPlayingMessage: 'Server Failure',
          topRatedLoading: false,
          topRatedSeries: null,
          topRatedMessage: null,
          popularLoading: false,
          popularSeries: null,
          popularMessage: null,
        )
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingSeries.execute());
      },
    );
  });
}
