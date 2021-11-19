import 'package:ditonton/presentation/pages/watchlist_series_page.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentasion/pages/watchlist_movies_page.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Watchlist'),
            bottom: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.movie),
              ),
              Tab(
                icon: Icon(Icons.tv),
              )
            ]),
          ),
          body: TabBarView(
            children: [
              WatchlistMoviesPage(),
              WatchlistSeriesPage(),
            ],
          ),
        ),
      ),
    );
  }
}
