import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
        centerTitle: true,
      ),
      body: Text('Display NewsList!'),
    );
  }
}
