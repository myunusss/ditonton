part of 'watchlist_series_bloc_cubit.dart';

class WatchlistSeriesState extends Equatable {
  final bool watchlistLoading;
  final List<Series>? watchlistSeries;
  final String? message;

  const WatchlistSeriesState({
    this.watchlistLoading = false,
    this.watchlistSeries,
    this.message,
  });

  WatchlistSeriesState copyWith({
    bool? watchlistLoading = false,
    List<Series>? watchlistSeries,
    String? message,
    bool clearMessage = false,
  }) {
    return WatchlistSeriesState(
      watchlistLoading: watchlistLoading ?? this.watchlistLoading,
      watchlistSeries: watchlistSeries ?? this.watchlistSeries,
      message: message ?? this.message,
    );
  }

  factory WatchlistSeriesState.initialState() => WatchlistSeriesState(
        watchlistLoading: false,
        watchlistSeries: null,
        message: null,
      );

  @override
  List<Object?> get props => [
        watchlistLoading,
        watchlistSeries,
        message,
      ];
}
