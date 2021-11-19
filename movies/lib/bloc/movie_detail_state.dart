part of 'movie_detail_bloc_cubit.dart';

class MovieDetailState extends Equatable {
  final bool detailLoading;
  final bool isAddedToWatchlist;
  final String? savedMessage;
  final String? saveErrorMessage;
  final String? message;
  final bool recommendationLoading;
  final MovieDetail? movieDetail;
  final List<Movie>? movieRecommendations;

  const MovieDetailState({
    this.detailLoading = false,
    this.isAddedToWatchlist = false,
    this.savedMessage,
    this.saveErrorMessage,
    this.message,
    this.recommendationLoading = false,
    this.movieDetail,
    this.movieRecommendations,
  });

  MovieDetailState copyWith({
    bool? detailLoading,
    bool? isAddedToWatchlist,
    String? savedMessage,
    String? saveErrorMessage,
    String? message,
    bool? recommendationLoading,
    MovieDetail? movieDetail,
    List<Movie>? movieRecommendations,
    bool clearMessage = false,
    bool clearSavedMessage = false,
    bool clearSaveErrorMessage = false,
  }) {
    return MovieDetailState(
      detailLoading: detailLoading ?? this.detailLoading,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      savedMessage: clearSavedMessage ? null : savedMessage ?? this.savedMessage,
      saveErrorMessage: clearSaveErrorMessage ? null : saveErrorMessage ?? this.saveErrorMessage,
      message: clearMessage ? null : message ?? this.message,
      recommendationLoading: recommendationLoading ?? this.recommendationLoading,
      movieDetail: movieDetail ?? this.movieDetail,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
    );
  }

  factory MovieDetailState.initialState() => MovieDetailState(
        detailLoading: false,
        isAddedToWatchlist: false,
        savedMessage: null,
        saveErrorMessage: null,
        message: null,
        recommendationLoading: false,
        movieDetail: null,
        movieRecommendations: null,
      );

  @override
  List<Object?> get props => [
        detailLoading,
        isAddedToWatchlist,
        savedMessage,
        saveErrorMessage,
        message,
        recommendationLoading,
        movieDetail,
        movieRecommendations,
      ];

  bool get isErrorSave => saveErrorMessage != null;
}
