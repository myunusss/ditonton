import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/bloc/top_rated_series_bloc_cubit.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_series_bloc_cubit_test.mocks.dart';

@GenerateMocks([
  GetTopRatedSeries,
])
void main() {
  late TopRatedSeriesBlocCubit topRatedSeriesBlocCubit;
  late MockGetTopRatedSeries mockGetTopRatedSeries;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    topRatedSeriesBlocCubit = TopRatedSeriesBlocCubit(
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

  group('Get Top Rated Series', () {
    test('should be initial state', () {
      expect(topRatedSeriesBlocCubit.state, TopRatedSeriesState.initialState());
    });

    blocTest<TopRatedSeriesBlocCubit, TopRatedSeriesState>(
      'Should emit [topRatedLoading, topRatedSries] data when data is gotten successfully',
      build: () {
        when(mockGetTopRatedSeries.execute()).thenAnswer((_) async => Right(tSeriesList));
        return topRatedSeriesBlocCubit;
      },
      act: (bloc) => bloc.fetchTopRatedSeries(),
      expect: () => [
        TopRatedSeriesState(
          message: null,
          topRatedLoading: true,
          topRatedSeries: null,
        ),
        TopRatedSeriesState(
          message: null,
          topRatedLoading: false,
          topRatedSeries: tSeriesList,
        ),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      },
    );

    blocTest<TopRatedSeriesBlocCubit, TopRatedSeriesState>(
      'Should emit [topRatedLoading, message error] data when data is unsuccessfully',
      build: () {
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedSeriesBlocCubit;
      },
      act: (bloc) => bloc.fetchTopRatedSeries(),
      expect: () => [
        TopRatedSeriesState(
          message: null,
          topRatedLoading: true,
          topRatedSeries: null,
        ),
        TopRatedSeriesState(
          message: 'Server Failure',
          topRatedLoading: false,
          topRatedSeries: null,
        ),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      },
    );
  });
}
