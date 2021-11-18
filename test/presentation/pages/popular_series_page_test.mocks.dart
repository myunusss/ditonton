// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton/test/presentation/pages/popular_series_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:bloc/bloc.dart' as _i5;
import 'package:ditonton/bloc/popular_series_bloc_cubit.dart' as _i3;
import 'package:ditonton/domain/usecases/get_popular_series.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetPopularSeries_0 extends _i1.Fake implements _i2.GetPopularSeries {
}

class _FakePopularSeriesState_1 extends _i1.Fake
    implements _i3.PopularSeriesState {}

class _FakeStreamSubscription_2<T> extends _i1.Fake
    implements _i4.StreamSubscription<T> {}

/// A class which mocks [PopularSeriesBlocCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockPopularSeriesBlocCubit extends _i1.Mock
    implements _i3.PopularSeriesBlocCubit {
  MockPopularSeriesBlocCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetPopularSeries get getPopularSeries =>
      (super.noSuchMethod(Invocation.getter(#getPopularSeries),
          returnValue: _FakeGetPopularSeries_0()) as _i2.GetPopularSeries);
  @override
  _i3.PopularSeriesState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakePopularSeriesState_1()) as _i3.PopularSeriesState);
  @override
  _i4.Stream<_i3.PopularSeriesState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.PopularSeriesState>.empty())
          as _i4.Stream<_i3.PopularSeriesState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  _i4.Future<void> fetchPopularSeries() =>
      (super.noSuchMethod(Invocation.method(#fetchPopularSeries, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.StreamSubscription<_i3.PopularSeriesState> listen(
          void Function(_i3.PopularSeriesState)? onData,
          {Function? onError,
          void Function()? onDone,
          bool? cancelOnError}) =>
      (super.noSuchMethod(
              Invocation.method(#listen, [
                onData
              ], {
                #onError: onError,
                #onDone: onDone,
                #cancelOnError: cancelOnError
              }),
              returnValue: _FakeStreamSubscription_2<_i3.PopularSeriesState>())
          as _i4.StreamSubscription<_i3.PopularSeriesState>);
  @override
  void emit(_i3.PopularSeriesState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i5.Change<_i3.PopularSeriesState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  String toString() => super.toString();
}
