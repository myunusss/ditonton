import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:equatable/equatable.dart';

part 'series_list_state.dart';

class SeriesListBlocCubit extends Cubit<SeriesListState> {
  final GetPopularSeries getPopularSeries;
  final GetNowPlayingSeries getNowPlayingSeries;
  final GetTopRatedSeries getTopRatedSeries;

  SeriesListBlocCubit(
    this.getPopularSeries,
    this.getNowPlayingSeries,
    this.getTopRatedSeries,
  ) : super(
          SeriesListState.initialState(),
        );

  Future<void> fetchPopularSeries() async {
    emit(state.copywith(popularLoading: true));

    final result = await getPopularSeries.execute();

    result.fold((failure) async {
      emit(state.copywith(
        popularLoading: false,
        popularMessage: failure.message,
      ));
    }, (data) async {
      emit(state.copywith(
        popularLoading: false,
        popularSeries: data,
      ));
    });
  }

  Future<void> fetchNowPlayingSeries() async {
    emit(state.copywith(nowPlayingLoading: true));

    final result = await getNowPlayingSeries.execute();

    result.fold((failure) async {
      emit(state.copywith(
        nowPlayingLoading: false,
        nowPlayingMessage: failure.message,
      ));
    }, (data) async {
      emit(state.copywith(
        nowPlayingLoading: false,
        nowPlayingSeries: data,
      ));
    });
  }

  Future<void> fetchTopRatedSeries() async {
    emit(state.copywith(topRatedLoading: true));

    final result = await getTopRatedSeries.execute();

    result.fold((failure) async {
      emit(state.copywith(
        topRatedLoading: false,
        topRatedMessage: failure.message,
      ));
    }, (data) async {
      emit(state.copywith(
        topRatedLoading: false,
        topRatedSeries: data,
      ));
    });
  }
}
