part of 'watchlist_movies_bloc_cubit.dart';

class WatchlistMoviesState extends Equatable {
  final bool watchlistLoading;
  final List<Movie>? watchlistMovies;
  final String? message;

  const WatchlistMoviesState({
    this.watchlistLoading = false,
    this.watchlistMovies,
    this.message,
  });

  WatchlistMoviesState copyWith({
    bool? watchlistLoading = false,
    List<Movie>? watchlistMovies,
    String? message,
    bool clearMessage = false,
  }) {
    return WatchlistMoviesState(
      watchlistLoading: watchlistLoading ?? this.watchlistLoading,
      watchlistMovies: watchlistMovies ?? this.watchlistMovies,
      message: message ?? this.message,
    );
  }

  factory WatchlistMoviesState.initialState() => WatchlistMoviesState(
        watchlistLoading: false,
        watchlistMovies: null,
        message: null,
      );

  @override
  List<Object?> get props => [
        watchlistLoading,
        watchlistMovies,
        message,
      ];
}
