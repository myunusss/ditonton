part of 'top_rated_series_bloc_cubit.dart';

class TopRatedSeriesState extends Equatable {
  final bool topRatedLoading;
  final List<Series>? topRatedSeries;
  final String? message;

  const TopRatedSeriesState({
    this.topRatedLoading = false,
    this.topRatedSeries,
    this.message,
  });

  TopRatedSeriesState copyWith({
    bool? topRatedLoading = false,
    List<Series>? topRatedSeries,
    String? message,
    bool clearMessage = false,
  }) {
    return TopRatedSeriesState(
      topRatedLoading: topRatedLoading ?? this.topRatedLoading,
      topRatedSeries: topRatedSeries ?? this.topRatedSeries,
      message: message ?? this.message,
    );
  }

  factory TopRatedSeriesState.initialState() => TopRatedSeriesState(
        topRatedLoading: false,
        topRatedSeries: null,
        message: null,
      );

  @override
  List<Object?> get props => [
        topRatedLoading,
        topRatedSeries,
        message,
      ];
}
