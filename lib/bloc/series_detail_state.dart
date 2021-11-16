part of 'series_detail_bloc_cubit.dart';

class SeriesDetailState extends Equatable {
  final bool detailLoading;
  final bool isAddedToWatchlist;
  final String? savedMessage;
  final String? saveErrorMessage;
  final String? message;
  final bool recommendationLoading;
  final SeriesDetail? seriesDetail;
  final List<Series>? seriesRecommendations;

  const SeriesDetailState(
      {this.detailLoading = false,
      this.isAddedToWatchlist = false,
      this.savedMessage,
      this.saveErrorMessage,
      this.message,
      this.recommendationLoading = false,
      this.seriesDetail,
      this.seriesRecommendations});

  SeriesDetailState copyWith({
    bool? detailLoading,
    bool? isAddedToWatchlist,
    String? savedMessage,
    String? saveErrorMessage,
    String? message,
    bool? recommendationLoading,
    SeriesDetail? seriesDetail,
    List<Series>? seriesRecommendations,
    bool clearMessage = false,
    bool clearSavedMessage = false,
    bool clearSaveErrorMessage = false,
  }) {
    return SeriesDetailState(
      detailLoading: detailLoading ?? this.detailLoading,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      savedMessage: clearSavedMessage ? null : savedMessage ?? this.savedMessage,
      saveErrorMessage: clearSaveErrorMessage ? null : saveErrorMessage ?? this.saveErrorMessage,
      message: clearMessage ? null : message ?? this.message,
      recommendationLoading: recommendationLoading ?? this.recommendationLoading,
      seriesDetail: seriesDetail ?? this.seriesDetail,
      seriesRecommendations: seriesRecommendations ?? this.seriesRecommendations,
    );
  }

  factory SeriesDetailState.initialState() => SeriesDetailState(
        detailLoading: false,
        isAddedToWatchlist: false,
        savedMessage: null,
        saveErrorMessage: null,
        message: null,
        recommendationLoading: false,
        seriesDetail: null,
        seriesRecommendations: null,
      );

  @override
  List<Object?> get props => [
        detailLoading,
        isAddedToWatchlist,
        savedMessage,
        saveErrorMessage,
        message,
        recommendationLoading,
        seriesDetail,
        seriesRecommendations,
      ];

  bool get isErrorSave => saveErrorMessage != null;
}
