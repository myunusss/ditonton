part of 'series_list_bloc_cubit.dart';

class SeriesListState extends Equatable {
  final bool popularLoading;
  final List<Series>? popularSeries;
  final String? popularMessage;

  final bool nowPlayingLoading;
  final List<Series>? nowPlayingSeries;
  final String? nowPlayingMessage;

  final bool topRatedLoading;
  final List<Series>? topRatedSeries;
  final String? topRatedMessage;

  const SeriesListState({
    this.popularLoading = false,
    this.popularSeries,
    this.popularMessage,
    this.nowPlayingLoading = false,
    this.nowPlayingSeries,
    this.nowPlayingMessage,
    this.topRatedLoading = false,
    this.topRatedSeries,
    this.topRatedMessage,
  });

  SeriesListState copywith({
    bool? popularLoading,
    List<Series>? popularSeries,
    String? popularMessage,
    bool? nowPlayingLoading,
    List<Series>? nowPlayingSeries,
    String? nowPlayingMessage,
    bool? topRatedLoading,
    List<Series>? topRatedSeries,
    String? topRatedMessage,
  }) {
    return SeriesListState(
      nowPlayingLoading: nowPlayingLoading ?? this.nowPlayingLoading,
      nowPlayingMessage: nowPlayingMessage ?? this.nowPlayingMessage,
      nowPlayingSeries: nowPlayingSeries ?? this.nowPlayingSeries,
      popularLoading: popularLoading ?? this.popularLoading,
      popularMessage: popularMessage ?? this.popularMessage,
      popularSeries: popularSeries ?? this.popularSeries,
      topRatedLoading: topRatedLoading ?? this.topRatedLoading,
      topRatedMessage: topRatedMessage ?? this.topRatedMessage,
      topRatedSeries: topRatedSeries ?? this.topRatedSeries,
    );
  }

  factory SeriesListState.initialState() => SeriesListState(
        popularLoading: false,
        popularSeries: null,
        popularMessage: null,
        nowPlayingLoading: false,
        nowPlayingSeries: null,
        nowPlayingMessage: null,
        topRatedLoading: false,
        topRatedSeries: null,
        topRatedMessage: null,
      );

  @override
  List<Object?> get props => [
        popularLoading,
        popularSeries,
        popularMessage,
        nowPlayingLoading,
        nowPlayingSeries,
        nowPlayingMessage,
        topRatedLoading,
        topRatedSeries,
        topRatedMessage,
      ];
}
