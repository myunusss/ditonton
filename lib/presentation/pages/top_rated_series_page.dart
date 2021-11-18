import 'package:ditonton/bloc/top_rated_series_bloc_cubit.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TopRatedSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-series';

  @override
  _TopRatedSeriesPageState createState() => _TopRatedSeriesPageState();
}

class _TopRatedSeriesPageState extends State<TopRatedSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => updateList());
  }

  updateList() {
    context.read<TopRatedSeriesBlocCubit>().fetchTopRatedSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedSeriesBlocCubit, TopRatedSeriesState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state.topRatedLoading) {
              return Center(
                key: Key('loading'),
                child: CircularProgressIndicator(),
              );
            } else if (!state.topRatedLoading && state.topRatedSeries != null) {
              final series = state.topRatedSeries;
              return ListView.builder(
                key: Key('listview'),
                itemBuilder: (context, index) {
                  final serie = series![index];
                  return SeriesCard(serie, () => updateList());
                },
                itemCount: series!.length,
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
