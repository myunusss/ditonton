import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';

part 'movie_detail_state.dart';

class MovieDetailBlocCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailBlocCubit(
    this.getMovieDetail,
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
    this.getMovieRecommendations,
  ) : super(MovieDetailState.initialState());

  Future<void> fetchMovieDetail(int id) async {
    emit(state.copyWith(
      detailLoading: true,
      recommendationLoading: true,
      clearMessage: true,
    ));

    final detailResult = await getMovieDetail.execute(id);

    detailResult.fold((failure) async {
      emit(state.copyWith(
        detailLoading: false,
        recommendationLoading: false,
        message: failure.message,
      ));
    }, (data) async {
      emit(state.copyWith(detailLoading: false, movieDetail: data));

      final recommendationResult = await getMovieRecommendations.execute(id);

      recommendationResult.fold((failure) async {
        emit(state.copyWith(
          recommendationLoading: false,
          message: failure.message,
        ));
      }, (data) async {
        emit(state.copyWith(
          recommendationLoading: false,
          movieRecommendations: data,
        ));
      });
    });
  }

  Future<void> addWatchlist(MovieDetail movieDetail) async {
    final result = await saveWatchlist.execute(movieDetail);

    result.fold((failure) async {
      emit(state.copyWith(
        saveErrorMessage: failure.message,
      ));
    }, (data) async {
      emit(state.copyWith(
        savedMessage: data,
      ));
    });

    getWatchlistStatus(movieDetail.id);
  }

  Future<void> deleteWatchlist(MovieDetail movieDetail) async {
    final result = await removeWatchlist.execute(movieDetail);

    result.fold((failure) async {
      emit(state.copyWith(
        saveErrorMessage: failure.message,
      ));
    }, (data) async {
      emit(state.copyWith(
        savedMessage: data,
      ));
    });

    getWatchlistStatus(movieDetail.id);
  }

  Future<void> getWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(state.copyWith(
      isAddedToWatchlist: result,
      clearMessage: true,
      clearSaveErrorMessage: true,
      savedMessage: null,
    ));
  }
}
