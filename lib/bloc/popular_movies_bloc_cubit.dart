import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'popular_movies_state.dart';

class PopularMoviesBlocCubit extends Cubit<PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBlocCubit(
    this.getPopularMovies,
  ) : super(
          PopularMoviesState.initialState(),
        );

  Future<void> fetchPopularMovies() async {
    emit(state.copyWith(
      popularLoading: true,
      clearMessage: true,
    ));

    final result = await getPopularMovies.execute();

    result.fold((failure) async {
      emit(state.copyWith(
        popularLoading: false,
        message: failure.message,
      ));
    }, (data) async {
      emit(state.copyWith(
        popularLoading: false,
        popularMovies: data,
      ));
    });
  }
}
