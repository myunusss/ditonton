import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:equatable/equatable.dart';

part 'popular_series_state.dart';

class PopularSeriesBlocCubit extends Cubit<PopularSeriesState> {
  final GetPopularSeries getPopularSeries;

  PopularSeriesBlocCubit(
    this.getPopularSeries,
  ) : super(
          PopularSeriesState.initialState(),
        );

  Future<void> fetchPopularSeries() async {
    emit(state.copyWith(
      popularLoading: true,
      clearMessage: true,
    ));

    final result = await getPopularSeries.execute();

    result.fold((failure) async {
      emit(state.copyWith(
        popularLoading: false,
        message: failure.message,
      ));
    }, (data) async {
      emit(state.copyWith(
        popularLoading: false,
        popularSeries: data,
      ));
    });
  }
}
