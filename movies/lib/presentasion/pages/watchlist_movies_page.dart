import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/watchlist_movies_bloc_cubit.dart';
import 'package:movies/presentasion/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => updateList());
  }

  updateList() {
    context.read<WatchlistMoviesBlocCubit>().fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMoviesBlocCubit, WatchlistMoviesState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.watchlistLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!state.watchlistLoading && state.watchlistMovies != null) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.watchlistMovies![index];
                return MovieCard(movie, () => updateList());
              },
              itemCount: state.watchlistMovies!.length,
            );
          } else if (state.message != null) {
            return Center(
              child: Text(state.message!),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
