import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMoviesBlocCubit])
void main() {
  late MockTopRatedMoviesBlocCubit mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedMoviesBlocCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBlocCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      TopRatedMoviesState(
        message: null,
        topRatedLoading: true,
        topRatedMovies: null,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        TopRatedMoviesState(
          message: null,
          topRatedLoading: true,
          topRatedMovies: null,
        ),
      ),
    );

    final loadingWidget = find.byKey(Key('loading'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(loadingWidget, findsOneWidget);
  });

  testWidgets('Page should display message when something error', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      TopRatedMoviesState(
        message: 'Message',
        topRatedLoading: false,
        topRatedMovies: null,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        TopRatedMoviesState(
          message: 'Message',
          topRatedLoading: false,
          topRatedMovies: null,
        ),
      ),
    );

    final messageError = find.byKey(Key('message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(messageError, findsOneWidget);
  });

  testWidgets('Page should display list Meries', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      TopRatedMoviesState(
        message: null,
        topRatedLoading: false,
        topRatedMovies: testMovieList,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        TopRatedMoviesState(
          message: null,
          topRatedLoading: false,
          topRatedMovies: testMovieList,
        ),
      ),
    );

    final watchlistButton = find.byKey(Key('listview'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(watchlistButton, findsOneWidget);
  });
}
