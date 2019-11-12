import 'package:flutter_hacker_news/src/models/item_model.dart';
import 'package:flutter_hacker_news/src/resources/news_api_provider.dart';
import 'package:flutter_hacker_news/src/resources/news_db_provider.dart';

class Repository {
  List<Source> _sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> _caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() async {
    return _sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;
    for (source in _sources) {
      item = await source.fetchItem(id);
      if (item != null) break;
    }

    for (var cache in _caches) {
      if (cache.runtimeType != source.runtimeType) cache.addItem(item);
    }

    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}
