import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/http_ssl_pinning.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_series_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_series_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/search_series_page.dart';
import 'package:ditonton/presentation/pages/series_detail_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_series_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/bloc/search_movies_bloc.dart';
import 'package:ditonton/bloc/search_series_bloc.dart';
import 'package:ditonton/bloc/movie_detail_bloc_cubit.dart';
import 'package:ditonton/bloc/series_detail_bloc_cubit.dart';
import 'package:ditonton/bloc/popular_movies_bloc_cubit.dart';
import 'package:ditonton/bloc/popular_series_bloc_cubit.dart';
import 'package:ditonton/bloc/top_rated_series_bloc_cubit.dart';
import 'package:ditonton/bloc/top_rated_movies_bloc_cubit.dart';
import 'package:ditonton/bloc/movie_list_bloc_cubit.dart';
import 'package:ditonton/bloc/series_list_bloc_cubit.dart';
import 'package:ditonton/bloc/watchlist_movies_bloc_cubit.dart';
import 'package:ditonton/bloc/watchlist_series_bloc_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBlocCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesDetailBlocCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBlocCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularSeriesBlocCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBlocCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedSeriesBlocCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieListBlocCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesListBlocCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBlocCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistSeriesBlocCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: HomeMoviePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case HomeSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeSeriesPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularSeriesPage());
            case TopRatedSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedSeriesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SeriesDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchSeriesPage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :( ...'),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
