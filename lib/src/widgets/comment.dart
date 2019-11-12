import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return SpinKitFoldingCube(
            color: Colors.redAccent,
          );
        }
        final columnChildren = <Widget>[
          ListTile(
            title: buildText(snapshot.data.text),
            subtitle: snapshot.data.by == ""
                ? Text("Deleted!")
                : Text(snapshot.data.by),
            contentPadding: EdgeInsets.only(
              left: depth * 16.0,
              right: 16.0,
            ),
          ),
          Divider(),
        ];

        snapshot.data.kids.forEach((kid) {
          columnChildren.add(
            Comment(
              itemId: itemId,
              itemMap: itemMap,
              depth: depth + 1,
            ),
          );
        });

        return Column(
          children: columnChildren,
        );
      },
    );
  }

  Widget buildText(String rawText) {
    final text = rawText
        .replaceAll('&#x27', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '');
    return Text(text);
  }
}
