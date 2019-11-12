import 'package:flutter_hacker_news/src/models/item_model.dart';
import 'package:flutter_hacker_news/src/resources/news_api_provider.dart';
import 'package:flutter_hacker_news/src/resources/news_db_provider.dart';

class Repository {
  final NewsApiProvider apiProvider = NewsApiProvider();
  final NewsDbrovider dbProvider = NewsDbrovider();

  Future<List<int>> fetchTopIds() async {
    return await apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    var fetchedItem = await dbProvider.fetchItem(id);
    if (fetchedItem != null) return fetchedItem;

    fetchedItem = await apiProvider.fetchItem(id);
    dbProvider.addItem(fetchedItem);

    return fetchedItem;
  }
}
