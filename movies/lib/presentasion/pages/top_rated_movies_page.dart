import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/top_rated_movies_bloc_cubit.dart';
import 'package:movies/presentasion/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => updateList());
  }

  updateList() {
    context.read<TopRatedMoviesBlocCubit>().fetTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesBlocCubit, TopRatedMoviesState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state.topRatedLoading) {
              return Center(
                key: Key('loading'),
                child: CircularProgressIndicator(),
              );
            } else if (!state.topRatedLoading && state.topRatedMovies != null) {
              final movies = state.topRatedMovies;
              return ListView.builder(
                key: Key('listview'),
                itemBuilder: (context, index) {
                  final movie = movies![index];
                  return MovieCard(movie, () => updateList());
                },
                itemCount: movies!.length,
              );
            } else if (state.message != null) {
              return Center(
                key: Key('message'),
                child: Text(state.message!),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
