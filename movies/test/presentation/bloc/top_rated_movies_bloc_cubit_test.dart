import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'top_rated_movies_bloc_cubit_test.mocks.dart';

@GenerateMocks([
  GetTopRatedMovies,
])
void main() {
  late TopRatedMoviesBlocCubit topRatedMoviesBlocCubit;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBlocCubit = TopRatedMoviesBlocCubit(
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

  final tMovieList = <Movie>[tMovie];

  group('Get Top Rated Movie', () {
    test('should be initial state', () {
      expect(topRatedMoviesBlocCubit.state, TopRatedMoviesState.initialState());
    });

    blocTest<TopRatedMoviesBlocCubit, TopRatedMoviesState>(
      'Should emit [topRatedLoading, topRatedMovies] data when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right(tMovieList));
        return topRatedMoviesBlocCubit;
      },
      act: (bloc) => bloc.fetTopRatedMovies(),
      expect: () => [
        TopRatedMoviesState(
          message: null,
          topRatedLoading: true,
          topRatedMovies: null,
        ),
        TopRatedMoviesState(
          message: null,
          topRatedLoading: false,
          topRatedMovies: tMovieList,
        ),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMoviesBlocCubit, TopRatedMoviesState>(
      'Should emit [topRatedLoading, message error] data when data is unsuccessfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedMoviesBlocCubit;
      },
      act: (bloc) => bloc.fetTopRatedMovies(),
      expect: () => [
        TopRatedMoviesState(
          message: null,
          topRatedLoading: true,
          topRatedMovies: null,
        ),
        TopRatedMoviesState(
          message: 'Server Failure',
          topRatedLoading: false,
          topRatedMovies: null,
        ),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
