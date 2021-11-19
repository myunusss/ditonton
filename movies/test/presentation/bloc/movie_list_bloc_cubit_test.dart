import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'movie_list_bloc_cubit_test.mocks.dart';

@GenerateMocks([
  GetTopRatedMovies,
  GetNowPlayingMovies,
  GetPopularMovies,
])
void main() {
  late MovieListBlocCubit movieListBlocCubit;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    movieListBlocCubit = MovieListBlocCubit(
      mockGetPopularMovies,
      mockGetNowPlayingMovies,
      mockGetTopRatedMovies,
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
  final tMovies = <Movie>[tMovie];

  group('Get Popular Movies', () {
    test('should be initial state', () {
      expect(movieListBlocCubit.state, MovieListState.initialState());
    });

    blocTest<MovieListBlocCubit, MovieListState>(
      'Should emit [popularLoading, popularMovies] data when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer((_) async => Right(tMovies));
        return movieListBlocCubit;
      },
      act: (bloc) => bloc.fetchPopularMovies(),
      expect: () => [
        MovieListState(
          nowPlayingLoading: false,
          nowPlayingMovies: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedMovies: null,
          topRatedMessage: null,
          popularLoading: true,
          popularMovies: null,
          popularMessage: null,
        ),
        MovieListState(
          nowPlayingLoading: false,
          nowPlayingMovies: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedMovies: null,
          topRatedMessage: null,
          popularLoading: false,
          popularMovies: tMovies,
          popularMessage: null,
        )
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<MovieListBlocCubit, MovieListState>(
      'Should emit [popularLoading, popularMessage] data when unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBlocCubit;
      },
      act: (bloc) => bloc.fetchPopularMovies(),
      expect: () => [
        MovieListState(
          nowPlayingLoading: false,
          nowPlayingMovies: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedMovies: null,
          topRatedMessage: null,
          popularLoading: true,
          popularMovies: null,
          popularMessage: null,
        ),
        MovieListState(
          nowPlayingLoading: false,
          nowPlayingMovies: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedMovies: null,
          topRatedMessage: null,
          popularLoading: false,
          popularMovies: null,
          popularMessage: 'Server Failure',
        )
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });

  group('Get Top Rated Movies', () {
    test('should be initial state', () {
      expect(movieListBlocCubit.state, MovieListState.initialState());
    });

    blocTest<MovieListBlocCubit, MovieListState>(
      'Should emit [topRatedLoading, topRatedMovies] data when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right(tMovies));
        return movieListBlocCubit;
      },
      act: (bloc) => bloc.fetchTopRatedMovies(),
      expect: () => [
        MovieListState(
          nowPlayingLoading: false,
          nowPlayingMovies: null,
          nowPlayingMessage: null,
          topRatedLoading: true,
          topRatedMovies: null,
          topRatedMessage: null,
          popularLoading: false,
          popularMovies: null,
          popularMessage: null,
        ),
        MovieListState(
          nowPlayingLoading: false,
          nowPlayingMovies: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedMovies: tMovies,
          topRatedMessage: null,
          popularLoading: false,
          popularMovies: null,
          popularMessage: null,
        )
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MovieListBlocCubit, MovieListState>(
      'Should emit [topRatedLoading, topRatedMessage] data when unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBlocCubit;
      },
      act: (bloc) => bloc.fetchTopRatedMovies(),
      expect: () => [
        MovieListState(
          nowPlayingLoading: false,
          nowPlayingMovies: null,
          nowPlayingMessage: null,
          topRatedLoading: true,
          topRatedMovies: null,
          topRatedMessage: null,
          popularLoading: false,
          popularMovies: null,
          popularMessage: null,
        ),
        MovieListState(
          nowPlayingLoading: false,
          nowPlayingMovies: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedMovies: null,
          topRatedMessage: 'Server Failure',
          popularLoading: false,
          popularMovies: null,
          popularMessage: null,
        )
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });

  group('Get Now Playing Movies', () {
    test('should be initial state', () {
      expect(movieListBlocCubit.state, MovieListState.initialState());
    });

    blocTest<MovieListBlocCubit, MovieListState>(
      'Should emit [nowPlayingLoading, nowPlayingMovies] data when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => Right(tMovies));
        return movieListBlocCubit;
      },
      act: (bloc) => bloc.fetchNowPlayingMovies(),
      expect: () => [
        MovieListState(
          nowPlayingLoading: true,
          nowPlayingMovies: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedMovies: null,
          topRatedMessage: null,
          popularLoading: false,
          popularMovies: null,
          popularMessage: null,
        ),
        MovieListState(
          nowPlayingLoading: false,
          nowPlayingMovies: tMovies,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedMovies: null,
          topRatedMessage: null,
          popularLoading: false,
          popularMovies: null,
          popularMessage: null,
        )
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<MovieListBlocCubit, MovieListState>(
      'Should emit [nowPlayingLoading, nowPlayingMessage] data when unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBlocCubit;
      },
      act: (bloc) => bloc.fetchNowPlayingMovies(),
      expect: () => [
        MovieListState(
          nowPlayingLoading: true,
          nowPlayingMovies: null,
          nowPlayingMessage: null,
          topRatedLoading: false,
          topRatedMovies: null,
          topRatedMessage: null,
          popularLoading: false,
          popularMovies: null,
          popularMessage: null,
        ),
        MovieListState(
          nowPlayingLoading: false,
          nowPlayingMovies: null,
          nowPlayingMessage: 'Server Failure',
          topRatedLoading: false,
          topRatedMovies: null,
          topRatedMessage: null,
          popularLoading: false,
          popularMovies: null,
          popularMessage: null,
        )
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}
