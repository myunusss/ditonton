part of 'popular_series_bloc_cubit.dart';

class PopularSeriesState extends Equatable {
  final bool popularLoading;
  final List<Series>? popularSeries;
  final String? message;

  const PopularSeriesState({
    this.popularLoading = false,
    this.popularSeries,
    this.message,
  });

  PopularSeriesState copyWith({
    bool? popularLoading = false,
    List<Series>? popularSeries,
    String? message,
    bool clearMessage = false,
  }) {
    return PopularSeriesState(
      popularLoading: popularLoading ?? this.popularLoading,
      popularSeries: popularSeries ?? this.popularSeries,
      message: message ?? this.message,
    );
  }

  factory PopularSeriesState.initialState() => PopularSeriesState(
        popularLoading: false,
        popularSeries: null,
        message: null,
      );

  @override
  List<Object?> get props => [
        popularLoading,
        popularSeries,
        message,
      ];
}
