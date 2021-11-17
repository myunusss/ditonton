import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_series_state.dart';

class WatchlistSeriesBlocCubit extends Cubit<WatchlistSeriesState> {
  final GetWatchlistSeries getWatchlistSeries;

  WatchlistSeriesBlocCubit(
    this.getWatchlistSeries,
  ) : super(
          WatchlistSeriesState.initialState(),
        );

  Future<void> fetchWatchlistSeries() async {
    emit(state.copyWith(
      watchlistLoading: true,
      clearMessage: true,
    ));

    final result = await getWatchlistSeries.execute();

    result.fold((failure) async {
      emit(state.copyWith(
        watchlistLoading: false,
        message: failure.message,
      ));
    }, (data) async {
      emit(state.copyWith(
        watchlistLoading: false,
        watchlistSeries: data,
      ));
    });
  }
}
