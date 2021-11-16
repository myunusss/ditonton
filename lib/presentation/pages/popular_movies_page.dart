import 'package:ditonton/bloc/popular_movies_bloc_cubit.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => updateList());
  }

  updateList() {
    context.read<PopularMoviesBlocCubit>().fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBlocCubit, PopularMoviesState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state.popularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (!state.popularLoading && state.popularMovies != null) {
              final movies = state.popularMovies;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = movies![index];
                  return MovieCard(movie, () => updateList());
                },
                itemCount: movies!.length,
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
      ),
    );
  }
}
