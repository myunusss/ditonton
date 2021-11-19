import 'dart:convert';
import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:ditonton/data/datasources/series_remote_data_source.dart';
import 'package:ditonton/data/models/series_detail_model.dart';
import 'package:ditonton/data/models/series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late SeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient client;

  setUp(() {
    client = MockHttpClient();
    dataSource = SeriesRemoteDataSourceImpl(client: client);
  });

  group('get now playing series', () {
    final tSeriesList =
        SeriesResponse.fromJson(json.decode(readJson('dummy_data/now_playing_series.json')))
            .seriesList;
    test('should return list of now playing series model when the response code is 200', () async {
      // arrange
      when(client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'))).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/now_playing_series.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.getNowPlayingSeries();
      // assert
      expect(result, equals(tSeriesList));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final call = dataSource.getNowPlayingSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get popular series', () {
    final tSeriesList =
        SeriesResponse.fromJson(json.decode(readJson('dummy_data/now_playing_series.json')))
            .seriesList;
    test('should return list of popular series model when the response code is 200', () async {
      // arrange
      when(client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'))).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/now_playing_series.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.getPopularSeries();
      // assert
      expect(result, equals(tSeriesList));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final call = dataSource.getPopularSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated series', () {
    final tSeriesList =
        SeriesResponse.fromJson(json.decode(readJson('dummy_data/now_playing_series.json')))
            .seriesList;
    test('should return list of top rated series model when the response code is 200', () async {
      // arrange
      when(client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'))).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/now_playing_series.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.getTopRatedSeries();
      // assert
      expect(result, equals(tSeriesList));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final call = dataSource.getTopRatedSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get series detail', () {
    final tId = 1399;
    final tSeriesDetail =
        SeriesDetailResponse.fromJson(json.decode(readJson('dummy_data/series_detail.json')));
    test('should return series detail model when the response code is 200', () async {
      // arrange
      when(client.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY'))).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/series_detail.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final result = await dataSource.getSeriesDetail(tId);
      // assert
      expect(result, equals(tSeriesDetail));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(client.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final call = dataSource.getSeriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get series recommendations', () {
    final tSeriesList =
        SeriesResponse.fromJson(json.decode(readJson('dummy_data/series_recommendations.json')))
            .seriesList;
    final tId = 1;

    test('should return list of Series Model when the response code is 200', () async {
      // arrange
      when(client.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY'))).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/series_recommendations.json'), 200));
      // act
      final result = await dataSource.getSeriesRecommendations(tId);
      // assert
      expect(result, equals(tSeriesList));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(client.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
