part of 'top_rated_movies_bloc_cubit.dart';

class TopRatedMoviesState extends Equatable {
  final bool topRatedLoading;
  final List<Movie>? topRatedMovies;
  final String? message;

  const TopRatedMoviesState({
    this.topRatedLoading = false,
    this.topRatedMovies,
    this.message,
  });

  TopRatedMoviesState copyWith({
    bool? topRatedLoading = false,
    List<Movie>? topRatedMovies,
    String? message,
    bool clearMessage = false,
  }) {
    return TopRatedMoviesState(
      topRatedLoading: topRatedLoading ?? this.topRatedLoading,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      message: message ?? this.message,
    );
  }

  factory TopRatedMoviesState.initialState() => TopRatedMoviesState(
        topRatedLoading: false,
        topRatedMovies: null,
        message: null,
      );

  @override
  List<Object?> get props => [
        topRatedLoading,
        topRatedMovies,
        message,
      ];
}
