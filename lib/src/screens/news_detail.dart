import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;
  NewsDetail({this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Story Detail',
          style: TextStyle(
            color: Colors.redAccent,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('$itemId News Detail!!!'),
      ),
    );
  }
}
