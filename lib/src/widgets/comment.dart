import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;

  Comment({this.itemId, this.itemMap});

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
          Text(snapshot.data.text),
        ];

        snapshot.data.kids.forEach((kid) {
          columnChildren.add(
            Comment(
              itemId: itemId,
              itemMap: itemMap,
            ),
          );
        });

        return Column(
          children: columnChildren,
        );
      },
    );
  }
}
