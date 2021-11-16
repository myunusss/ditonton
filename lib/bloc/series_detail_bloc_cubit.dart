import 'package:ditonton/domain/usecases/get_series_detail.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';

part 'series_detail_state.dart';

class SeriesDetailBlocCubit extends Cubit<SeriesDetailState> {
  final GetSeriesDetail getSeriesDetail;
  final GetWatchListStatusSeries getWatchListStatusSeries;
  final SaveWatchlistSeries saveWatchlistSeries;
  final RemoveWatchlistSeries removeWatchlistSeries;
  final GetSeriesRecommendations getSeriesRecommendations;

  SeriesDetailBlocCubit(
    this.getSeriesDetail,
    this.getWatchListStatusSeries,
    this.saveWatchlistSeries,
    this.removeWatchlistSeries,
    this.getSeriesRecommendations,
  ) : super(SeriesDetailState.initialState());

  Future<void> fetchSeriesDetail(int id) async {
    emit(state.copyWith(
      detailLoading: true,
      recommendationLoading: true,
      clearMessage: true,
    ));

    final detailResult = await getSeriesDetail.execute(id);

    detailResult.fold((failure) async {
      emit(state.copyWith(
        detailLoading: false,
        recommendationLoading: false,
        message: failure.message,
      ));
    }, (data) async {
      emit(state.copyWith(detailLoading: false, seriesDetail: data));

      final recommendationResult = await getSeriesRecommendations.execute(id);

      recommendationResult.fold((failure) async {
        emit(state.copyWith(
          recommendationLoading: false,
          message: failure.message,
        ));
      }, (data) async {
        emit(state.copyWith(
          recommendationLoading: false,
          seriesRecommendations: data,
        ));
      });
    });
  }

  Future<void> addWatchlist(SeriesDetail seriesDetail) async {
    final result = await saveWatchlistSeries.execute(seriesDetail);

    result.fold((failure) async {
      emit(state.copyWith(
        saveErrorMessage: failure.message,
      ));
    }, (data) async {
      emit(state.copyWith(
        savedMessage: data,
      ));
    });

    getWatchlistStatus(seriesDetail.id);
  }

  Future<void> deleteWatchlist(SeriesDetail seriesDetail) async {
    final result = await removeWatchlistSeries.execute(seriesDetail);

    result.fold((failure) async {
      emit(state.copyWith(
        saveErrorMessage: failure.message,
      ));
    }, (data) async {
      emit(state.copyWith(
        savedMessage: data,
      ));
    });

    getWatchlistStatus(seriesDetail.id);
  }

  Future<void> getWatchlistStatus(int id) async {
    final result = await getWatchListStatusSeries.execute(id);
    emit(state.copyWith(
      isAddedToWatchlist: result,
      clearMessage: true,
      clearSaveErrorMessage: true,
      savedMessage: null,
    ));
  }
}
