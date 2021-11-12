import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/search_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'search_series_event.dart';
part 'search_series_state.dart';

class SearchSeriesBloc extends Bloc<SearchSeriesEvent, SearchSeriesState> {
  final SearchSeries _searchSeries;

  SearchSeriesBloc(this._searchSeries) : super(SearchEmpty());

  @override
  Stream<Transition<SearchSeriesEvent, SearchSeriesState>> transformEvents(
    Stream<SearchSeriesEvent> events,
    transitionFn,
  ) {
    return events.debounceTime(const Duration(milliseconds: 1000)).switchMap(transitionFn);
  }

  @override
  Stream<SearchSeriesState> mapEventToState(
    SearchSeriesEvent event,
  ) async* {
    if (event is OnQueryChanged) {
      final query = event.query;

      yield SearchLoading();
      final result = await _searchSeries.execute(query);

      yield* result.fold(
        (failure) async* {
          yield SearchError(failure.message);
        },
        (data) async* {
          yield SearchHasData(data);
        },
      );
    }
  }
}
