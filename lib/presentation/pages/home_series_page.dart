import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/bloc/series_list_bloc_cubit.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/presentation/pages/popular_series_page.dart';
import 'package:ditonton/presentation/pages/search_series_page.dart';
import 'package:ditonton/presentation/pages/series_detail_page.dart';
import 'package:ditonton/presentation/pages/top_rated_series_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series';

  @override
  _HomeSeriesPageState createState() => _HomeSeriesPageState();
}

class _HomeSeriesPageState extends State<HomeSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<SeriesListBlocCubit>()
      ..fetchNowPlayingSeries()
      ..fetchPopularSeries()
      ..fetchTopRatedSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchSeriesPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<SeriesListBlocCubit, SeriesListState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  if (state.nowPlayingLoading) {
                    return Center(
                      key: Key('loading-nowplaying'),
                      child: CircularProgressIndicator(),
                    );
                  } else if (!state.nowPlayingLoading && state.nowPlayingSeries != null) {
                    return SeriesList(state.nowPlayingSeries!);
                  } else if (state.nowPlayingMessage != null) {
                    return Center(
                      key: Key('message-nowplaying'),
                      child: Text(state.nowPlayingMessage!),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, PopularSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<SeriesListBlocCubit, SeriesListState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  if (state.popularLoading) {
                    return Center(
                      key: Key('loading-popular'),
                      child: CircularProgressIndicator(),
                    );
                  } else if (!state.popularLoading && state.popularSeries != null) {
                    return SeriesList(state.popularSeries!);
                  } else if (state.popularMessage != null) {
                    return Center(
                      key: Key('message-popular'),
                      child: Text(state.popularMessage!),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, TopRatedSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<SeriesListBlocCubit, SeriesListState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  if (state.topRatedLoading) {
                    return Center(
                      key: Key('loading-toprated'),
                      child: CircularProgressIndicator(),
                    );
                  } else if (!state.topRatedLoading && state.topRatedSeries != null) {
                    return SeriesList(state.topRatedSeries!);
                  } else if (state.topRatedMessage != null) {
                    return Center(
                      key: Key('message-toprated'),
                      child: Text(state.topRatedMessage!),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class SeriesList extends StatelessWidget {
  final List<Series> series;

  SeriesList(this.series);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = series[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SeriesDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: series.length,
      ),
    );
  }
}
