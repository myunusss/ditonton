import 'package:ditonton/bloc/series_detail_bloc_cubit.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/presentation/pages/series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'series_detail_page_test.mocks.dart';

@GenerateMocks([SeriesDetailBlocCubit])
void main() {
  late MockSeriesDetailBlocCubit mockNotifier;

  setUp(() {
    mockNotifier = MockSeriesDetailBlocCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SeriesDetailBlocCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Should display loading when fetching data in progress', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
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
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
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
      ),
    );

    await tester.pumpWidget(_makeTestableWidget(SeriesDetailPage(id: 1)));

    expect(find.byKey(Key('series_detail_loading')), findsOneWidget);
  });

  testWidgets('Watchlist button should display check icon when Series is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      SeriesDetailState(
        detailLoading: false,
        isAddedToWatchlist: true,
        message: null,
        saveErrorMessage: null,
        savedMessage: null,
        seriesDetail: testSeriesDetail,
        seriesRecommendations: <Series>[],
        recommendationLoading: false,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        SeriesDetailState(
          detailLoading: false,
          isAddedToWatchlist: true,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          seriesDetail: testSeriesDetail,
          seriesRecommendations: <Series>[],
          recommendationLoading: false,
        ),
      ),
    );

    final watchlistButton = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(SeriesDetailPage(id: 1)));

    expect(watchlistButton, findsOneWidget);
  });

  testWidgets('Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      SeriesDetailState(
        detailLoading: false,
        isAddedToWatchlist: false,
        message: null,
        saveErrorMessage: null,
        savedMessage: null,
        seriesDetail: testSeriesDetail,
        seriesRecommendations: <Series>[],
        recommendationLoading: false,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.fromIterable([
        SeriesDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          seriesDetail: testSeriesDetail,
          seriesRecommendations: <Series>[],
          recommendationLoading: false,
        ),
        SeriesDetailState(
          detailLoading: false,
          isAddedToWatchlist: true,
          message: null,
          saveErrorMessage: null,
          savedMessage: 'Added to Watchlist',
          seriesDetail: testSeriesDetail,
          seriesRecommendations: <Series>[],
          recommendationLoading: false,
        ),
      ]),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
      _makeTestableWidget(
        SeriesDetailPage(id: 1),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets('Watchlist button should display Snackbar when add to watchlist is failed',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      SeriesDetailState(
        detailLoading: false,
        isAddedToWatchlist: false,
        message: null,
        saveErrorMessage: null,
        savedMessage: null,
        seriesDetail: testSeriesDetail,
        seriesRecommendations: <Series>[],
        recommendationLoading: false,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.fromIterable([
        SeriesDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: 'Failed',
          seriesDetail: testSeriesDetail,
          seriesRecommendations: <Series>[],
          recommendationLoading: false,
        ),
        SeriesDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: 'Failed',
          seriesDetail: testSeriesDetail,
          seriesRecommendations: <Series>[],
          recommendationLoading: false,
        ),
      ]),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
      _makeTestableWidget(
        SeriesDetailPage(id: 1),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
