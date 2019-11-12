import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:flutter_hacker_news/src/resources/news_api_provider.dart';

void main() {
  test('fetchTopIds returns list of top ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4, 5]), 200);
    });

    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4, 5]);
  });

  test('fetchItem returns returns the item with specified id', () async {
    final newsApi = NewsApiProvider();
    final jsonMap = {'id': 123};
    newsApi.client = MockClient((request) async {
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(94);

    expect(item.id, 123);
  });
}
