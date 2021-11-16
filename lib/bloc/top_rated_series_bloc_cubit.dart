import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_series_state.dart';

class TopRatedSeriesBlocCubit extends Cubit<TopRatedSeriesState> {
  final GetTopRatedSeries getTopRatedSeries;

  TopRatedSeriesBlocCubit(
    this.getTopRatedSeries,
  ) : super(
          TopRatedSeriesState.initialState(),
        );

  Future<void> fetchTopRatedSeries() async {
    emit(state.copyWith(
      topRatedLoading: true,
      clearMessage: true,
    ));

    final result = await getTopRatedSeries.execute();

    result.fold((failure) async {
      emit(state.copyWith(
        topRatedLoading: false,
        message: failure.message,
      ));
    }, (data) async {
      emit(state.copyWith(
        topRatedLoading: false,
        topRatedSeries: data,
      ));
    });
  }
}
