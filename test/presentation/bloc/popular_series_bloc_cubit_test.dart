import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/bloc/popular_series_bloc_cubit.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../provider/popular_series_notifier_test.mocks.dart';

@GenerateMocks([
  GetPopularSeries,
])
void main() {
  late PopularSeriesBlocCubit popularSeriesBlocCubit;
  late MockGetPopularSeries mockGetPopularSeries;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();
    popularSeriesBlocCubit = PopularSeriesBlocCubit(
      mockGetPopularSeries,
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
      expect(popularSeriesBlocCubit.state, PopularSeriesState.initialState());
    });

    blocTest<PopularSeriesBlocCubit, PopularSeriesState>(
      'Should emit [popularLoading, popularSries] data when data is gotten successfully',
      build: () {
        when(mockGetPopularSeries.execute()).thenAnswer((_) async => Right(tSeriesList));
        return popularSeriesBlocCubit;
      },
      act: (bloc) => bloc.fetchPopularSeries(),
      expect: () => [
        PopularSeriesState(
          message: null,
          popularLoading: true,
          popularSeries: null,
        ),
        PopularSeriesState(
          message: null,
          popularLoading: false,
          popularSeries: tSeriesList,
        ),
      ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      },
    );

    blocTest<PopularSeriesBlocCubit, PopularSeriesState>(
      'Should emit [popularLoading, message error] data when data is unsuccessfully',
      build: () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularSeriesBlocCubit;
      },
      act: (bloc) => bloc.fetchPopularSeries(),
      expect: () => [
        PopularSeriesState(
          message: null,
          popularLoading: true,
          popularSeries: null,
        ),
        PopularSeriesState(
          message: 'Server Failure',
          popularLoading: false,
          popularSeries: null,
        ),
      ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      },
    );
  });
}
