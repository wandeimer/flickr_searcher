import 'package:flutter/material.dart';

Widget homePageWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/9/9b/Flickr_logo.png')
      ],
    ),
  );
}