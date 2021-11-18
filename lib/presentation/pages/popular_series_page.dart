import 'package:ditonton/bloc/popular_series_bloc_cubit.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-series';

  @override
  _PopularSeriesPageState createState() => _PopularSeriesPageState();
}

class _PopularSeriesPageState extends State<PopularSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => updateList());
  }

  updateList() {
    context.read<PopularSeriesBlocCubit>().fetchPopularSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularSeriesBlocCubit, PopularSeriesState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state.popularLoading) {
              return Center(
                key: Key('loading-popular'),
                child: CircularProgressIndicator(),
              );
            } else if (!state.popularLoading && state.popularSeries != null) {
              final series = state.popularSeries;
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
