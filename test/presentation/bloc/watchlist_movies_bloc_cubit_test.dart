import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/bloc/watchlist_movies_bloc_cubit.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movies_bloc_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
])
void main() {
  late WatchlistMoviesBlocCubit watchlistMoviesBlocCubit;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMoviesBlocCubit = WatchlistMoviesBlocCubit(
      mockGetWatchlistMovies,
    );
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  group('Get Watchlist Movie', () {
    test('should be initial state', () {
      expect(watchlistMoviesBlocCubit.state, WatchlistMoviesState.initialState());
    });

    blocTest<WatchlistMoviesBlocCubit, WatchlistMoviesState>(
      'Should emit [watchlistLoading, watchlistMovies] data when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer((_) async => Right(tMovieList));
        return watchlistMoviesBlocCubit;
      },
      act: (bloc) => bloc.fetchWatchlistMovies(),
      expect: () => [
        WatchlistMoviesState(
          message: null,
          watchlistLoading: true,
          watchlistMovies: null,
        ),
        WatchlistMoviesState(
          message: null,
          watchlistLoading: false,
          watchlistMovies: tMovieList,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMoviesBlocCubit, WatchlistMoviesState>(
      'Should emit [popularLoading, message error] data when data is unsuccessfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistMoviesBlocCubit;
      },
      act: (bloc) => bloc.fetchWatchlistMovies(),
      expect: () => [
        WatchlistMoviesState(
          message: null,
          watchlistLoading: true,
          watchlistMovies: null,
        ),
        WatchlistMoviesState(
          message: 'Server Failure',
          watchlistLoading: false,
          watchlistMovies: null,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}
