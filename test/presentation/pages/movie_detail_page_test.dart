import 'package:ditonton/bloc/movie_detail_bloc_cubit.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailBlocCubit])
void main() {
  late MockMovieDetailBlocCubit mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailBlocCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBlocCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Should display loading when fetching data in progress', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
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
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
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
      ),
    );

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byKey(Key('movie_detail_loading')), findsOneWidget);
  });

  testWidgets('Watchlist button should display check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      MovieDetailState(
        detailLoading: false,
        isAddedToWatchlist: true,
        message: null,
        saveErrorMessage: null,
        savedMessage: null,
        movieDetail: testMovieDetail,
        movieRecommendations: <Movie>[],
        recommendationLoading: false,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        MovieDetailState(
          detailLoading: false,
          isAddedToWatchlist: true,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          movieDetail: testMovieDetail,
          movieRecommendations: <Movie>[],
          recommendationLoading: false,
        ),
      ),
    );

    final watchlistButton = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButton, findsOneWidget);
  });

  testWidgets('Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      MovieDetailState(
        detailLoading: false,
        isAddedToWatchlist: false,
        message: null,
        saveErrorMessage: null,
        savedMessage: null,
        movieDetail: testMovieDetail,
        movieRecommendations: <Movie>[],
        recommendationLoading: false,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.fromIterable([
        MovieDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: null,
          movieDetail: testMovieDetail,
          movieRecommendations: <Movie>[],
          recommendationLoading: false,
        ),
        MovieDetailState(
          detailLoading: false,
          isAddedToWatchlist: true,
          message: null,
          saveErrorMessage: null,
          savedMessage: 'Added to Watchlist',
          movieDetail: testMovieDetail,
          movieRecommendations: <Movie>[],
          recommendationLoading: false,
        ),
      ]),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
      _makeTestableWidget(
        MovieDetailPage(id: 1),
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
      MovieDetailState(
        detailLoading: false,
        isAddedToWatchlist: false,
        message: null,
        saveErrorMessage: null,
        savedMessage: null,
        movieDetail: testMovieDetail,
        movieRecommendations: <Movie>[],
        recommendationLoading: false,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.fromIterable([
        MovieDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: 'Failed',
          movieDetail: testMovieDetail,
          movieRecommendations: <Movie>[],
          recommendationLoading: false,
        ),
        MovieDetailState(
          detailLoading: false,
          isAddedToWatchlist: false,
          message: null,
          saveErrorMessage: null,
          savedMessage: 'Failed',
          movieDetail: testMovieDetail,
          movieRecommendations: <Movie>[],
          recommendationLoading: false,
        ),
      ]),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(
      _makeTestableWidget(
        MovieDetailPage(id: 1),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
