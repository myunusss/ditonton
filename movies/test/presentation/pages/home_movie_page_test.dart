import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'home_movie_page_test.mocks.dart';

@GenerateMocks([MovieListBlocCubit])
void main() {
  late MockMovieListBlocCubit mockNotifier;

  setUp(() {
    mockNotifier = MockMovieListBlocCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieListBlocCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      MovieListState(
        topRatedMessage: null,
        topRatedLoading: true,
        topRatedMovies: null,
        popularLoading: true,
        popularMessage: null,
        popularMovies: null,
        nowPlayingLoading: true,
        nowPlayingMessage: null,
        nowPlayingMovies: null,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        MovieListState(
          topRatedMessage: null,
          topRatedLoading: true,
          topRatedMovies: null,
          popularLoading: true,
          popularMessage: null,
          popularMovies: null,
          nowPlayingLoading: true,
          nowPlayingMessage: null,
          nowPlayingMovies: null,
        ),
      ),
    );

    final loadingNowplaying = find.byKey(Key('loading-nowplaying'));
    final loadingToprated = find.byKey(Key('loading-toprated'));
    final loadingpopular = find.byKey(Key('loading-popular'));

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(loadingNowplaying, findsOneWidget);
    expect(loadingToprated, findsOneWidget);
    expect(loadingpopular, findsOneWidget);
  });

  testWidgets('Page should display message when something error', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      MovieListState(
        topRatedMessage: 'Failed',
        topRatedLoading: false,
        topRatedMovies: null,
        popularLoading: false,
        popularMessage: 'Failed',
        popularMovies: null,
        nowPlayingLoading: false,
        nowPlayingMessage: 'Failed',
        nowPlayingMovies: null,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        MovieListState(
          topRatedMessage: 'Failed',
          topRatedLoading: false,
          topRatedMovies: null,
          popularLoading: false,
          popularMessage: 'Failed',
          popularMovies: null,
          nowPlayingLoading: false,
          nowPlayingMessage: 'Failed',
          nowPlayingMovies: null,
        ),
      ),
    );

    final messageNowplaying = find.byKey(Key('message-nowplaying'));
    final messageToprated = find.byKey(Key('message-toprated'));
    final messagePopular = find.byKey(Key('message-popular'));

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(messageNowplaying, findsOneWidget);
    expect(messageToprated, findsOneWidget);
    expect(messagePopular, findsOneWidget);
  });
}
