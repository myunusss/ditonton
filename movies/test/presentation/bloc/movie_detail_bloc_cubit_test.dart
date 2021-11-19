import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBlocCubit movieDetailBlocCubit;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBlocCubit = MovieDetailBlocCubit(
      mockGetMovieDetail,
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetMovieRecommendations,
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
  final tId = 1;

  group('Get Movie Detail', () {
    test('should be initial state', () {
      expect(movieDetailBlocCubit.state, MovieDetailState.initialState());
    });

    blocTest<MovieDetailBlocCubit, MovieDetailState>(
      'Should emit [detailLoading, recommendationLoading, movieDetail, movieRecommendations] data when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer((_) async => Right(tMovies));
        return movieDetailBlocCubit;
      },
      act: (bloc) => bloc.fetchMovieDetail(tId),
      expect: () => [
        MovieDetailState(
          detailLoading: true,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          movieDetail: null,
          movieRecommendations: null,
          recommendationLoading: true,
        ),
        MovieDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          movieDetail: testMovieDetail,
          movieRecommendations: null,
          recommendationLoading: true,
        ),
        MovieDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          movieDetail: testMovieDetail,
          movieRecommendations: tMovies,
          recommendationLoading: false,
        )
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBlocCubit, MovieDetailState>(
      'Should emit [detailLoading, recommendationLoading, message error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBlocCubit;
      },
      act: (bloc) => bloc.fetchMovieDetail(tId),
      expect: () => [
        MovieDetailState(
          detailLoading: true,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          movieDetail: null,
          movieRecommendations: null,
          recommendationLoading: true,
        ),
        MovieDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: 'Server Failure',
          saveErrorMessage: null,
          savedMessage: null,
          movieDetail: null,
          movieRecommendations: null,
          recommendationLoading: false,
        ),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group('Movie Watchlist', () {
    blocTest<MovieDetailBlocCubit, MovieDetailState>(
      'should get the movie watchlist status',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return movieDetailBlocCubit;
      },
      act: (bloc) => bloc.getWatchlistStatus(tId),
      expect: () => [
        MovieDetailState(
          detailLoading: false,
          isAddedToWatchlist: true,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          movieDetail: null,
          movieRecommendations: null,
          recommendationLoading: false,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<MovieDetailBlocCubit, MovieDetailState>(
      'should execute save watchlist when function called',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return movieDetailBlocCubit;
      },
      act: (bloc) {
        bloc.addWatchlist(testMovieDetail);
        bloc.getWatchlistStatus(tId);
      },
      expect: () => [
        MovieDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: 'Added to Watchlist',
          movieDetail: null,
          movieRecommendations: null,
          recommendationLoading: false,
        ),
        MovieDetailState(
          detailLoading: false,
          isAddedToWatchlist: true,
          message: null,
          saveErrorMessage: null,
          savedMessage: 'Added to Watchlist',
          movieDetail: null,
          movieRecommendations: null,
          recommendationLoading: false,
        ),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<MovieDetailBlocCubit, MovieDetailState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Removed from Watchlist'));
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => false);
        return movieDetailBlocCubit;
      },
      act: (bloc) {
        bloc.deleteWatchlist(testMovieDetail);
        bloc.getWatchlistStatus(tId);
      },
      expect: () => [
        MovieDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: 'Removed from Watchlist',
          movieDetail: null,
          movieRecommendations: null,
          recommendationLoading: false,
        ),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<MovieDetailBlocCubit, MovieDetailState>(
      'should return error when add watchlist function called',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => false);
        return movieDetailBlocCubit;
      },
      act: (bloc) {
        bloc.deleteWatchlist(testMovieDetail);
        bloc.getWatchlistStatus(tId);
      },
      expect: () => [
        MovieDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: 'Failed',
          savedMessage: null,
          movieDetail: null,
          movieRecommendations: null,
          recommendationLoading: false,
        ),
        MovieDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          movieDetail: null,
          movieRecommendations: null,
          recommendationLoading: false,
        ),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );
  });
}
