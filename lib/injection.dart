import 'package:core/core.dart';
import 'package:ditonton/bloc/popular_series_bloc_cubit.dart';
import 'package:ditonton/bloc/search_series_bloc.dart';
import 'package:ditonton/bloc/series_detail_bloc_cubit.dart';
import 'package:ditonton/bloc/series_list_bloc_cubit.dart';
import 'package:ditonton/bloc/top_rated_series_bloc_cubit.dart';
import 'package:ditonton/bloc/watchlist_series_bloc_cubit.dart';
import 'package:ditonton/data/datasources/series_local_data_source.dart';
import 'package:ditonton/data/datasources/series_remote_data_source.dart';
import 'package:ditonton/data/repositories/series_repository_impl.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:ditonton/domain/usecases/get_series_detail.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series.dart';
import 'package:ditonton/domain/usecases/search_series.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => SearchMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBlocCubit(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => SeriesDetailBlocCubit(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBlocCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularSeriesBlocCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBlocCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedSeriesBlocCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieListBlocCubit(
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => SeriesListBlocCubit(
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesBlocCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistSeriesBlocCubit(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<SeriesRepository>(
    () => SeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<SeriesRemoteDataSource>(
      () => SeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
