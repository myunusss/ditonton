// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton/test/presentation/pages/series_detail_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i12;
import 'dart:ui' as _i13;

import 'package:ditonton/common/state_enum.dart' as _i10;
import 'package:ditonton/domain/entities/series.dart' as _i11;
import 'package:ditonton/domain/entities/series_detail.dart' as _i7;
import 'package:ditonton/domain/usecases/get_series_detail.dart' as _i2;
import 'package:ditonton/domain/usecases/get_series_recommendations.dart'
    as _i3;
import 'package:ditonton/domain/usecases/get_watchlist_series.dart' as _i8;
import 'package:ditonton/domain/usecases/get_watchlist_status_series.dart'
    as _i4;
import 'package:ditonton/domain/usecases/remove_watchlist_series.dart' as _i6;
import 'package:ditonton/domain/usecases/save_watchlist_series.dart' as _i5;
import 'package:ditonton/presentation/provider/series_detail_notifier.dart'
    as _i9;
import 'package:ditonton/presentation/provider/watchlist_series_notifier.dart'
    as _i14;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetSeriesDetail_0 extends _i1.Fake implements _i2.GetSeriesDetail {}

class _FakeGetSeriesRecommendations_1 extends _i1.Fake
    implements _i3.GetSeriesRecommendations {}

class _FakeGetWatchListStatusSeries_2 extends _i1.Fake
    implements _i4.GetWatchListStatusSeries {}

class _FakeSaveWatchlistSeries_3 extends _i1.Fake
    implements _i5.SaveWatchlistSeries {}

class _FakeRemoveWatchlistSeries_4 extends _i1.Fake
    implements _i6.RemoveWatchlistSeries {}

class _FakeSeriesDetail_5 extends _i1.Fake implements _i7.SeriesDetail {}

class _FakeGetWatchlistSeries_6 extends _i1.Fake
    implements _i8.GetWatchlistSeries {}

/// A class which mocks [SeriesDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesDetailNotifier extends _i1.Mock
    implements _i9.SeriesDetailNotifier {
  MockSeriesDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetSeriesDetail get getSeriesDetail =>
      (super.noSuchMethod(Invocation.getter(#getSeriesDetail),
          returnValue: _FakeGetSeriesDetail_0()) as _i2.GetSeriesDetail);
  @override
  _i3.GetSeriesRecommendations get getSeriesRecommendations =>
      (super.noSuchMethod(Invocation.getter(#getSeriesRecommendations),
              returnValue: _FakeGetSeriesRecommendations_1())
          as _i3.GetSeriesRecommendations);
  @override
  _i4.GetWatchListStatusSeries get getWatchListStatusSeries =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatusSeries),
              returnValue: _FakeGetWatchListStatusSeries_2())
          as _i4.GetWatchListStatusSeries);
  @override
  _i5.SaveWatchlistSeries get saveWatchlistSeries => (super.noSuchMethod(
      Invocation.getter(#saveWatchlistSeries),
      returnValue: _FakeSaveWatchlistSeries_3()) as _i5.SaveWatchlistSeries);
  @override
  _i6.RemoveWatchlistSeries get removeWatchlistSeries =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlistSeries),
              returnValue: _FakeRemoveWatchlistSeries_4())
          as _i6.RemoveWatchlistSeries);
  @override
  _i7.SeriesDetail get series => (super.noSuchMethod(Invocation.getter(#series),
      returnValue: _FakeSeriesDetail_5()) as _i7.SeriesDetail);
  @override
  _i10.RequestState get seriesState =>
      (super.noSuchMethod(Invocation.getter(#seriesState),
          returnValue: _i10.RequestState.Empty) as _i10.RequestState);
  @override
  List<_i11.Series> get seriesRecommendations =>
      (super.noSuchMethod(Invocation.getter(#seriesRecommendations),
          returnValue: <_i11.Series>[]) as List<_i11.Series>);
  @override
  _i10.RequestState get recommendationState =>
      (super.noSuchMethod(Invocation.getter(#recommendationState),
          returnValue: _i10.RequestState.Empty) as _i10.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get isAddedToWatchlist =>
      (super.noSuchMethod(Invocation.getter(#isAddedToWatchlist),
          returnValue: false) as bool);
  @override
  String get watchlistMessage =>
      (super.noSuchMethod(Invocation.getter(#watchlistMessage), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i12.Future<void> fetchSeriesDetail(int? id) => (super.noSuchMethod(
      Invocation.method(#fetchSeriesDetail, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i12.Future<void>);
  @override
  _i12.Future<void> addWatchlist(_i7.SeriesDetail? series) =>
      (super.noSuchMethod(Invocation.method(#addWatchlist, [series]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i12.Future<void>);
  @override
  _i12.Future<void> removeFromWatchlist(_i7.SeriesDetail? series) =>
      (super.noSuchMethod(Invocation.method(#removeFromWatchlist, [series]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i12.Future<void>);
  @override
  _i12.Future<void> loadWatchlistStatus(int? id) => (super.noSuchMethod(
      Invocation.method(#loadWatchlistStatus, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i12.Future<void>);
  @override
  void addListener(_i13.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i13.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}

/// A class which mocks [WatchlistSeriesNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistSeriesNotifier extends _i1.Mock
    implements _i14.WatchlistSeriesNotifier {
  MockWatchlistSeriesNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.GetWatchlistSeries get getWatchlistSeries =>
      (super.noSuchMethod(Invocation.getter(#getWatchlistSeries),
          returnValue: _FakeGetWatchlistSeries_6()) as _i8.GetWatchlistSeries);
  @override
  List<_i11.Series> get watchlistSeries =>
      (super.noSuchMethod(Invocation.getter(#watchlistSeries),
          returnValue: <_i11.Series>[]) as List<_i11.Series>);
  @override
  _i10.RequestState get watchlistState =>
      (super.noSuchMethod(Invocation.getter(#watchlistState),
          returnValue: _i10.RequestState.Empty) as _i10.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i12.Future<void> fetchWatchlistSeries() => (super.noSuchMethod(
      Invocation.method(#fetchWatchlistSeries, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i12.Future<void>);
  @override
  void addListener(_i13.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i13.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
