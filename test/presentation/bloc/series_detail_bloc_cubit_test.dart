import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/bloc/series_detail_bloc_cubit.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_series_detail.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'series_detail_bloc_cubit_test.mocks.dart';

@GenerateMocks([
  GetSeriesDetail,
  GetSeriesRecommendations,
  GetWatchListStatusSeries,
  SaveWatchlistSeries,
  RemoveWatchlistSeries,
])
void main() {
  late SeriesDetailBlocCubit seriesDetailBlocCubit;
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late MockGetWatchListStatusSeries mockGetWatchListStatusSeries;
  late MockSaveWatchlistSeries mockSaveWatchlistSeries;
  late MockRemoveWatchlistSeries mockRemoveWatchlistSeries;

  setUp(() {
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    mockGetWatchListStatusSeries = MockGetWatchListStatusSeries();
    mockSaveWatchlistSeries = MockSaveWatchlistSeries();
    mockRemoveWatchlistSeries = MockRemoveWatchlistSeries();
    seriesDetailBlocCubit = SeriesDetailBlocCubit(
      mockGetSeriesDetail,
      mockGetWatchListStatusSeries,
      mockSaveWatchlistSeries,
      mockRemoveWatchlistSeries,
      mockGetSeriesRecommendations,
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
  final tId = 1;

  group('Get Movie Detail', () {
    test('should be initial state', () {
      expect(seriesDetailBlocCubit.state, SeriesDetailState.initialState());
    });

    blocTest<SeriesDetailBlocCubit, SeriesDetailState>(
      'Should emit [detailLoading, recommendationLoading, seriesDetail, seriesRecommendations] data when data is gotten successfully',
      build: () {
        when(mockGetSeriesDetail.execute(tId)).thenAnswer((_) async => Right(testSeriesDetail));
        when(mockGetSeriesRecommendations.execute(tId)).thenAnswer((_) async => Right(tSeriesList));
        return seriesDetailBlocCubit;
      },
      act: (bloc) => bloc.fetchSeriesDetail(tId),
      expect: () => [
        SeriesDetailState(
          detailLoading: true,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          seriesDetail: null,
          seriesRecommendations: null,
          recommendationLoading: true,
        ),
        SeriesDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          seriesDetail: testSeriesDetail,
          seriesRecommendations: null,
          recommendationLoading: true,
        ),
        SeriesDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          seriesDetail: testSeriesDetail,
          seriesRecommendations: tSeriesList,
          recommendationLoading: false,
        )
      ],
      verify: (bloc) {
        verify(mockGetSeriesDetail.execute(tId));
        verify(mockGetSeriesRecommendations.execute(tId));
      },
    );

    blocTest<SeriesDetailBlocCubit, SeriesDetailState>(
      'Should emit [detailLoading, recommendationLoading, message error] when get search is unsuccessful',
      build: () {
        when(mockGetSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return seriesDetailBlocCubit;
      },
      act: (bloc) => bloc.fetchSeriesDetail(tId),
      expect: () => [
        SeriesDetailState(
          detailLoading: true,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          seriesDetail: null,
          seriesRecommendations: null,
          recommendationLoading: true,
        ),
        SeriesDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: 'Server Failure',
          saveErrorMessage: null,
          savedMessage: null,
          seriesDetail: null,
          seriesRecommendations: null,
          recommendationLoading: false,
        ),
      ],
      verify: (bloc) {
        verify(mockGetSeriesDetail.execute(tId));
      },
    );
  });

  group('Series Watchlist', () {
    blocTest<SeriesDetailBlocCubit, SeriesDetailState>(
      'should get the series watchlist status',
      build: () {
        when(mockGetWatchListStatusSeries.execute(tId)).thenAnswer((_) async => true);
        return seriesDetailBlocCubit;
      },
      act: (bloc) => bloc.getWatchlistStatus(tId),
      expect: () => [
        SeriesDetailState(
          detailLoading: false,
          isAddedToWatchlist: true,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          seriesDetail: null,
          seriesRecommendations: null,
          recommendationLoading: false,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatusSeries.execute(tId));
      },
    );

    blocTest<SeriesDetailBlocCubit, SeriesDetailState>(
      'should execute save watchlist when function called',
      build: () {
        when(mockSaveWatchlistSeries.execute(testSeriesDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchListStatusSeries.execute(tId)).thenAnswer((_) async => true);
        return seriesDetailBlocCubit;
      },
      act: (bloc) {
        bloc.addWatchlist(testSeriesDetail);
        bloc.getWatchlistStatus(tId);
      },
      expect: () => [
        SeriesDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: 'Added to Watchlist',
          seriesDetail: null,
          seriesRecommendations: null,
          recommendationLoading: false,
        ),
        SeriesDetailState(
          detailLoading: false,
          isAddedToWatchlist: true,
          message: null,
          saveErrorMessage: null,
          savedMessage: 'Added to Watchlist',
          seriesDetail: null,
          seriesRecommendations: null,
          recommendationLoading: false,
        ),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistSeries.execute(testSeriesDetail));
        verify(mockGetWatchListStatusSeries.execute(tId));
      },
    );

    blocTest<SeriesDetailBlocCubit, SeriesDetailState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlistSeries.execute(testSeriesDetail))
            .thenAnswer((_) async => Right('Removed from Watchlist'));
        when(mockGetWatchListStatusSeries.execute(tId)).thenAnswer((_) async => false);
        return seriesDetailBlocCubit;
      },
      act: (bloc) {
        bloc.deleteWatchlist(testSeriesDetail);
        bloc.getWatchlistStatus(tId);
      },
      expect: () => [
        SeriesDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: 'Removed from Watchlist',
          seriesDetail: null,
          seriesRecommendations: null,
          recommendationLoading: false,
        ),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistSeries.execute(testSeriesDetail));
        verify(mockGetWatchListStatusSeries.execute(tId));
      },
    );

    blocTest<SeriesDetailBlocCubit, SeriesDetailState>(
      'should return error when add watchlist function called',
      build: () {
        when(mockRemoveWatchlistSeries.execute(testSeriesDetail))
            .thenAnswer((_) async => left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatusSeries.execute(tId)).thenAnswer((_) async => false);
        return seriesDetailBlocCubit;
      },
      act: (bloc) {
        bloc.deleteWatchlist(testSeriesDetail);
        bloc.getWatchlistStatus(tId);
      },
      expect: () => [
        SeriesDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: 'Failed',
          savedMessage: null,
          seriesDetail: null,
          seriesRecommendations: null,
          recommendationLoading: false,
        ),
        SeriesDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          seriesDetail: null,
          seriesRecommendations: null,
          recommendationLoading: false,
        ),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistSeries.execute(testSeriesDetail));
        verify(mockGetWatchListStatusSeries.execute(tId));
      },
    );
  });
}
