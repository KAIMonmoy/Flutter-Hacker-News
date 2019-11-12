import 'dart:io';
import 'dart:async';

import 'package:flutter_hacker_news/src/models/item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

const _kItemsTableName = "Items";

class NewsDbrovider {
  static Database _db = null;

  init() async {
    if (_db == null) {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, "items.db");
      _db = await openDatabase(path, version: 1,
          onCreate: (Database newDb, int version) {
        newDb.execute('''
              CREATE TABLE $_kItemsTableName
              (
                id INTEGER PRIMARY_KEY,
                type TEXT,
                by TEXT,
                time INTEGER,
                text TEXT,
                parent INTEGER,
                kids BLOB,
                dead INTEGER,
                deleted INTEGER,
                url TEXT,
                descendants INTEGER
              )
            ''');
      });
    }
    return _db;
  }

  fetchItem(int id) async {
    final maps = await _db.query(_kItemsTableName,
        columns: null, where: "id = ?", whereArgs: [id]);
    if (maps.length == 1) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  addItem(ItemModel item) {
    return _db.insert(_kItemsTableName, item.toDbMap());
  }
}
