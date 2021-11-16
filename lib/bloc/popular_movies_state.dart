part of 'popular_movies_bloc_cubit.dart';

class PopularMoviesState extends Equatable {
  final bool popularLoading;
  final List<Movie>? popularMovies;
  final String? message;

  const PopularMoviesState({
    this.popularLoading = false,
    this.popularMovies,
    this.message,
  });

  PopularMoviesState copyWith({
    bool? popularLoading = false,
    List<Movie>? popularMovies,
    String? message,
    bool clearMessage = false,
  }) {
    return PopularMoviesState(
      popularLoading: popularLoading ?? this.popularLoading,
      popularMovies: popularMovies ?? this.popularMovies,
      message: message ?? this.message,
    );
  }

  factory PopularMoviesState.initialState() => PopularMoviesState(
        popularLoading: false,
        popularMovies: null,
        message: null,
      );

  @override
  List<Object?> get props => [
        popularLoading,
        popularMovies,
        message,
      ];
}
