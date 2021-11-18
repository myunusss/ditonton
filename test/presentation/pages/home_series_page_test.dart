import 'package:ditonton/bloc/series_list_bloc_cubit.dart';
import 'package:ditonton/presentation/pages/home_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_series_page_test.mocks.dart';

@GenerateMocks([SeriesListBlocCubit])
void main() {
  late MockSeriesListBlocCubit mockNotifier;

  setUp(() {
    mockNotifier = MockSeriesListBlocCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SeriesListBlocCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      SeriesListState(
        topRatedMessage: null,
        topRatedLoading: true,
        topRatedSeries: null,
        popularLoading: true,
        popularMessage: null,
        popularSeries: null,
        nowPlayingLoading: true,
        nowPlayingMessage: null,
        nowPlayingSeries: null,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        SeriesListState(
          topRatedMessage: null,
          topRatedLoading: true,
          topRatedSeries: null,
          popularLoading: true,
          popularMessage: null,
          popularSeries: null,
          nowPlayingLoading: true,
          nowPlayingMessage: null,
          nowPlayingSeries: null,
        ),
      ),
    );

    final loadingNowplaying = find.byKey(Key('loading-nowplaying'));
    final loadingToprated = find.byKey(Key('loading-toprated'));
    final loadingpopular = find.byKey(Key('loading-popular'));

    await tester.pumpWidget(_makeTestableWidget(HomeSeriesPage()));

    expect(loadingNowplaying, findsOneWidget);
    expect(loadingToprated, findsOneWidget);
    expect(loadingpopular, findsOneWidget);
  });

  testWidgets('Page should display message when something error', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(
      SeriesListState(
        topRatedMessage: 'Failed',
        topRatedLoading: false,
        topRatedSeries: null,
        popularLoading: false,
        popularMessage: 'Failed',
        popularSeries: null,
        nowPlayingLoading: false,
        nowPlayingMessage: 'Failed',
        nowPlayingSeries: null,
      ),
    );

    when(mockNotifier.stream).thenAnswer(
      (_) => Stream.value(
        SeriesListState(
          topRatedMessage: 'Failed',
          topRatedLoading: false,
          topRatedSeries: null,
          popularLoading: false,
          popularMessage: 'Failed',
          popularSeries: null,
          nowPlayingLoading: false,
          nowPlayingMessage: 'Failed',
          nowPlayingSeries: null,
        ),
      ),
    );

    final messageNowplaying = find.byKey(Key('message-nowplaying'));
    final messageToprated = find.byKey(Key('message-toprated'));
    final messagePopular = find.byKey(Key('message-popular'));

    await tester.pumpWidget(_makeTestableWidget(HomeSeriesPage()));

    expect(messageNowplaying, findsOneWidget);
    expect(messageToprated, findsOneWidget);
    expect(messagePopular, findsOneWidget);
  });
}
