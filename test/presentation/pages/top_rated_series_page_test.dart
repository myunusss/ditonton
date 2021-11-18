import 'package:ditonton/bloc/top_rated_series_bloc_cubit.dart';
import 'package:ditonton/presentation/pages/top_rated_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_series_page_test.mocks.dart';

@GenerateMocks([TopRatedSeriesBlocCubit])
void main() {
  late MockTopRatedSeriesBlocCubit mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedSeriesBlocCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedSeriesBlocCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      TopRatedSeriesState(
        message: null,
        topRatedLoading: true,
        topRatedSeries: null,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        TopRatedSeriesState(
          message: null,
          topRatedLoading: true,
          topRatedSeries: null,
        ),
      ),
    );

    final loadingWidget = find.byKey(Key('loading'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(loadingWidget, findsOneWidget);
  });

  testWidgets('Page should display message when something error', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      TopRatedSeriesState(
        message: 'Message',
        topRatedLoading: false,
        topRatedSeries: null,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        TopRatedSeriesState(
          message: 'Message',
          topRatedLoading: false,
          topRatedSeries: null,
        ),
      ),
    );

    final messageError = find.byKey(Key('message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(messageError, findsOneWidget);
  });

  testWidgets('Page should display list Meries', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      TopRatedSeriesState(
        message: null,
        topRatedLoading: false,
        topRatedSeries: testSeriesList,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        TopRatedSeriesState(
          message: null,
          topRatedLoading: false,
          topRatedSeries: testSeriesList,
        ),
      ),
    );

    final watchlistButton = find.byKey(Key('listview'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(watchlistButton, findsOneWidget);
  });
}
