import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

part 'movie_list_state.dart';

class MovieListBlocCubit extends Cubit<MovieListState> {
  final GetPopularMovies getPopularMovies;
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBlocCubit(
    this.getPopularMovies,
    this.getNowPlayingMovies,
    this.getTopRatedMovies,
  ) : super(
          MovieListState.initialState(),
        );

  Future<void> fetchPopularMovies() async {
    emit(state.copywith(popularLoading: true));

    final result = await getPopularMovies.execute();

    result.fold((failure) async {
      emit(state.copywith(
        popularLoading: false,
        popularMessage: failure.message,
      ));
    }, (data) async {
      emit(state.copywith(
        popularLoading: false,
        popularMovies: data,
      ));
    });
  }

  Future<void> fetchNowPlayingMovies() async {
    emit(state.copywith(nowPlayingLoading: true));

    final result = await getNowPlayingMovies.execute();

    result.fold((failure) async {
      emit(state.copywith(
        nowPlayingLoading: false,
        nowPlayingMessage: failure.message,
      ));
    }, (data) async {
      emit(state.copywith(
        nowPlayingLoading: false,
        nowPlayingMovies: data,
      ));
    });
  }

  Future<void> fetchTopRatedMovies() async {
    emit(state.copywith(topRatedLoading: true));

    final result = await getTopRatedMovies.execute();

    result.fold((failure) async {
      emit(state.copywith(
        topRatedLoading: false,
        topRatedMessage: failure.message,
      ));
    }, (data) async {
      emit(state.copywith(
        topRatedLoading: false,
        topRatedMovies: data,
      ));
    });
  }
}
