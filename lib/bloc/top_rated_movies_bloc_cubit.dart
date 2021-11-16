import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesBlocCubit extends Cubit<TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBlocCubit(
    this.getTopRatedMovies,
  ) : super(
          TopRatedMoviesState.initialState(),
        );

  Future<void> fetTopRatedMovies() async {
    emit(state.copyWith(
      topRatedLoading: true,
      clearMessage: true,
    ));

    final result = await getTopRatedMovies.execute();

    result.fold((failure) async {
      emit(state.copyWith(
        topRatedLoading: false,
        message: failure.message,
      ));
    }, (data) async {
      emit(state.copyWith(
        topRatedLoading: false,
        topRatedMovies: data,
      ));
    });
  }
}
