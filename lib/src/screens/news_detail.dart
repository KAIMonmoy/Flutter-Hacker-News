import 'package:flutter/material.dart';
import 'package:flutter_hacker_news/src/widgets/comment.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_hacker_news/src/blocs/comments_bloc.dart';
import 'package:flutter_hacker_news/src/blocs/comments_provider.dart';
import 'package:flutter_hacker_news/src/models/item_model.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;
  NewsDetail({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Story Detail',
        ),
        centerTitle: true,
      ),
      body: buildNewsDetailBody(bloc),
    );
  }

  Widget buildNewsDetailBody(CommentsBloc commentsBloc) {
    return StreamBuilder(
      stream: commentsBloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SpinKitFoldingCube(
              color: Colors.redAccent,
            ),
          );
        }

        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Center(
                child: SpinKitFoldingCube(
                  color: Colors.redAccent,
                ),
              );
            }

            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final commentsList = item.kids
        .map((kidId) => Comment(
              itemId: kidId,
              itemMap: itemMap,
              depth: 1,
            ))
        .toList();
    return ListView(
      children: <Widget>[
        buildTitle(item.title),
        ...commentsList,
      ],
    );
  }

  Widget buildTitle(String itemTitle) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(10.0),
      child: Text(
        itemTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.blue[200],
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
