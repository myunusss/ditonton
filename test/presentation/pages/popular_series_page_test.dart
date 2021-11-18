import 'package:ditonton/bloc/popular_series_bloc_cubit.dart';
import 'package:ditonton/presentation/pages/popular_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_series_page_test.mocks.dart';

@GenerateMocks([PopularSeriesBlocCubit])
void main() {
  late MockPopularSeriesBlocCubit mockNotifier;

  setUp(() {
    mockNotifier = MockPopularSeriesBlocCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularSeriesBlocCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      PopularSeriesState(
        message: null,
        popularLoading: true,
        popularSeries: null,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        PopularSeriesState(
          message: null,
          popularLoading: true,
          popularSeries: null,
        ),
      ),
    );

    final loadingWidget = find.byKey(Key('loading-popular'));

    await tester.pumpWidget(_makeTestableWidget(PopularSeriesPage()));

    expect(loadingWidget, findsOneWidget);
  });

  testWidgets('Page should display message when something error', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      PopularSeriesState(
        message: 'Message',
        popularLoading: false,
        popularSeries: null,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        PopularSeriesState(
          message: 'Message',
          popularLoading: false,
          popularSeries: null,
        ),
      ),
    );

    final messageError = find.byKey(Key('message'));

    await tester.pumpWidget(_makeTestableWidget(PopularSeriesPage()));

    expect(messageError, findsOneWidget);
  });

  testWidgets('Page should display list Series', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      PopularSeriesState(
        message: null,
        popularLoading: false,
        popularSeries: testSeriesList,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        PopularSeriesState(
          message: null,
          popularLoading: false,
          popularSeries: testSeriesList,
        ),
      ),
    );

    final watchlistButton = find.byKey(Key('listview'));

    await tester.pumpWidget(_makeTestableWidget(PopularSeriesPage()));

    expect(watchlistButton, findsOneWidget);
  });
}
