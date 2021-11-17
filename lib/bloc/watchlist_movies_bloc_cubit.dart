import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movies_state.dart';

class WatchlistMoviesBlocCubit extends Cubit<WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMoviesBlocCubit(
    this.getWatchlistMovies,
  ) : super(
          WatchlistMoviesState.initialState(),
        );

  Future<void> fetchWatchlistMovies() async {
    emit(state.copyWith(
      watchlistLoading: true,
      clearMessage: true,
    ));

    final result = await getWatchlistMovies.execute();

    result.fold((failure) async {
      emit(state.copyWith(
        watchlistLoading: false,
        message: failure.message,
      ));
    }, (data) async {
      emit(state.copyWith(
        watchlistLoading: false,
        watchlistMovies: data,
      ));
    });
  }
}
