import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesBlocCubit])
void main() {
  late MockPopularMoviesBlocCubit mockNotifier;

  setUp(() {
    mockNotifier = MockPopularMoviesBlocCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBlocCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      PopularMoviesState(
        message: null,
        popularLoading: true,
        popularMovies: null,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        PopularMoviesState(
          message: null,
          popularLoading: true,
          popularMovies: null,
        ),
      ),
    );

    final loadingWidget = find.byKey(Key('loading-popular'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(loadingWidget, findsOneWidget);
  });

  testWidgets('Page should display message when something error', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      PopularMoviesState(
        message: 'Message',
        popularLoading: false,
        popularMovies: null,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        PopularMoviesState(
          message: 'Message',
          popularLoading: false,
          popularMovies: null,
        ),
      ),
    );

    final messageError = find.byKey(Key('message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(messageError, findsOneWidget);
  });

  testWidgets('Page should display list movies', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      PopularMoviesState(
        message: null,
        popularLoading: false,
        popularMovies: testMovieList,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        PopularMoviesState(
          message: null,
          popularLoading: false,
          popularMovies: testMovieList,
        ),
      ),
    );

    final watchlistButton = find.byKey(Key('listview'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(watchlistButton, findsOneWidget);
  });
}
