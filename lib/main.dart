import 'package:flutter/material.dart';

import 'homePageWidget.dart';
import 'imageListPage.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void getImageList() {
    setState(() {
      //TODO request/responce to api flickr
      _imageLink =
          'https://farm66.staticflickr.com/65535/51563757609_83aacd59f6.jpg';
    });
  }

  String _imageLink = ''; //TODO remove
  bool _isSearching = false; //TODO remove
  bool _isHome = false; //TODO remove
  List<String> _images = [
    'https://farm66.staticflickr.com/65535/51563757609_83aacd59f6.jpg',
    'https://farm66.staticflickr.com/65535/51563757609_83aacd59f6.jpg',
    'https://farm66.staticflickr.com/65535/51563757609_83aacd59f6.jpg',
    'https://farm66.staticflickr.com/65535/51563757609_83aacd59f6.jpg',
    'https://farm66.staticflickr.com/65535/51563757609_83aacd59f6.jpg',
  ]; //TODO remove

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: !_isSearching
                  ? Text('Поиск изображений')
                  : TextField(decoration: InputDecoration(hintText: 'котики')),
              //TODO search bloc
              actions: [
                Padding(
                    padding: EdgeInsets.only(right: 1),
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        //TODO action
                      },
                    )),
                Padding(
                    padding: EdgeInsets.only(right: 1),
                    child: IconButton(
                      icon: Icon(Icons.bookmark_outlined),
                      onPressed: () {
                        //TODO action
                      },
                    )),
                if (!_isHome)
                  Padding(
                      padding: EdgeInsets.only(right: 1),
                      child: IconButton(
                        icon: Icon(Icons.view_column),
                        onPressed: () {
                          //TODO action
                        },
                      ))
              ],
            ),
            body: _isHome ? homePageWidget() : imageList(_images)));
  }
}
