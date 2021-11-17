import 'package:ditonton/bloc/watchlist_series_bloc_cubit.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/watchlist_series_notifier.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-series';

  @override
  _WatchlistSeriesPageState createState() => _WatchlistSeriesPageState();
}

class _WatchlistSeriesPageState extends State<WatchlistSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => updateList());
  }

  updateList() {
    context.read<WatchlistSeriesBlocCubit>().fetchWatchlistSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistSeriesBlocCubit, WatchlistSeriesState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.watchlistLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!state.watchlistLoading && state.watchlistSeries != null) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final series = state.watchlistSeries![index];
                return SeriesCard(series, () => updateList());
              },
              itemCount: state.watchlistSeries!.length,
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
