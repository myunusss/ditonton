import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'popular_movies_bloc_cubit_test.mocks.dart';

@GenerateMocks([
  GetPopularMovies,
])
void main() {
  late PopularMoviesBlocCubit popularMoviesBlocCubit;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBlocCubit = PopularMoviesBlocCubit(
      mockGetPopularMovies,
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

  group('Get Popular Movie', () {
    test('should be initial state', () {
      expect(popularMoviesBlocCubit.state, PopularMoviesState.initialState());
    });

    blocTest<PopularMoviesBlocCubit, PopularMoviesState>(
      'Should emit [popularLoading, popularMovies] data when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer((_) async => Right(tMovieList));
        return popularMoviesBlocCubit;
      },
      act: (bloc) => bloc.fetchPopularMovies(),
      expect: () => [
        PopularMoviesState(
          message: null,
          popularLoading: true,
          popularMovies: null,
        ),
        PopularMoviesState(
          message: null,
          popularLoading: false,
          popularMovies: tMovieList,
        ),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMoviesBlocCubit, PopularMoviesState>(
      'Should emit [popularLoading, message error] data when data is unsuccessfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularMoviesBlocCubit;
      },
      act: (bloc) => bloc.fetchPopularMovies(),
      expect: () => [
        PopularMoviesState(
          message: null,
          popularLoading: true,
          popularMovies: null,
        ),
        PopularMoviesState(
          message: 'Server Failure',
          popularLoading: false,
          popularMovies: null,
        ),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
