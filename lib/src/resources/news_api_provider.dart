import 'dart:convert';
import 'package:flutter_hacker_news/src/models/item_model.dart';
import 'package:http/http.dart' show Client;

const _kBaseURL = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final response = await client.get('$_kBaseURL/topstories.json');
    final ids = json.decode(response.body);

    return ids;
  }

  fetchItem(int id) async {
    final response = await client.get('$_kBaseURL/item/$id.json');
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
