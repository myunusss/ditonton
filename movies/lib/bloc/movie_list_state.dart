part of 'movie_list_bloc_cubit.dart';

class MovieListState extends Equatable {
  final bool popularLoading;
  final List<Movie>? popularMovies;
  final String? popularMessage;

  final bool nowPlayingLoading;
  final List<Movie>? nowPlayingMovies;
  final String? nowPlayingMessage;

  final bool topRatedLoading;
  final List<Movie>? topRatedMovies;
  final String? topRatedMessage;

  const MovieListState({
    this.popularLoading = false,
    this.popularMovies,
    this.popularMessage,
    this.nowPlayingLoading = false,
    this.nowPlayingMovies,
    this.nowPlayingMessage,
    this.topRatedLoading = false,
    this.topRatedMovies,
    this.topRatedMessage,
  });

  MovieListState copywith({
    bool? popularLoading,
    List<Movie>? popularMovies,
    String? popularMessage,
    bool? nowPlayingLoading,
    List<Movie>? nowPlayingMovies,
    String? nowPlayingMessage,
    bool? topRatedLoading,
    List<Movie>? topRatedMovies,
    String? topRatedMessage,
  }) {
    return MovieListState(
      nowPlayingLoading: nowPlayingLoading ?? this.nowPlayingLoading,
      nowPlayingMessage: nowPlayingMessage ?? this.nowPlayingMessage,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularLoading: popularLoading ?? this.popularLoading,
      popularMessage: popularMessage ?? this.popularMessage,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedLoading: topRatedLoading ?? this.topRatedLoading,
      topRatedMessage: topRatedMessage ?? this.topRatedMessage,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
    );
  }

  factory MovieListState.initialState() => MovieListState(
        popularLoading: false,
        popularMovies: null,
        popularMessage: null,
        nowPlayingLoading: false,
        nowPlayingMovies: null,
        nowPlayingMessage: null,
        topRatedLoading: false,
        topRatedMovies: null,
        topRatedMessage: null,
      );

  @override
  List<Object?> get props => [
        popularLoading,
        popularMovies,
        popularMessage,
        nowPlayingLoading,
        nowPlayingMovies,
        nowPlayingMessage,
        topRatedLoading,
        topRatedMovies,
        topRatedMessage,
      ];
}
