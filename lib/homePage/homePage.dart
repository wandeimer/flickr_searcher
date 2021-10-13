import 'package:flickr_searcher/imageFullPage/imageFullPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../photosData.dart';
import 'homePageWidget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final http.Client httpClient = http.Client();

  void loadMoreImages(int page) async {
    try {
      final newImages = await _fetchImages(myTextController.text, page);
      setState(() {
        _images.addAll(newImages);
      });
    } catch (_) {
      print('ERROR in getImagesLinkList');
    }
  }

  void searchImages(String text) async {
    try {
      final images = await _fetchImages(text, 0);
      setState(() {
        _images = images;
      });
    } catch (_) {
      print('ERROR in getImagesLinkList');
    }
  }

  Future<void> refreshImages() async {
    try {
      List<String> images = await _fetchImages(myTextController.text, 0);
      setState(() {
        _images = images;
      });
    } catch (_) {
      print('Error in getImagesLinkList');
    }
  }

  Future<List<String>> _fetchImages(String request, int page) async {
    final response = await httpClient.get(
      Uri.parse(
          'https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=a732eb364ff9081e190c87dec91d5ce4&text=' +
              request +
              '&per_page=40&page=' +
              page.toString() +
              '&format=json&nojsoncallback=1'), //todo rewrite
    );
    if (response.statusCode == 200) {
      final photosData = photosDataFromJson(response.body).photos.photo;
      return photosData.map((photo) {
        return 'https://farm' +
            // photo.farm.toString() + //TODO убрать эту залепу
            '66' +
            '.staticflickr.com/' +
            photo.server.toString() +
            '/' +
            photo.id.toString() +
            '_' +
            photo.secret.toString() +
            '.jpg';
      }).toList();
    }
    throw Exception('error fetching posts');
  }

  void changeColumnCount() {
    setState(() {
      switch (_columnCount) {
        case 1:
          _columnCount = 2;
          break;
        case 2:
          _columnCount = 4;
          break;
        case 4:
          _columnCount = 1;
          break;
      }
    });
  }

  final myTextController = TextEditingController();
  final scrollController = ScrollController();
  bool _isSearching = false; //TODO remove
  bool _isHome = false; //TODO remove
  List<String> _images = []; //TODO remove
  int _columnCount = 2;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          _images.length % 10 == 0) {
        loadMoreImages((_images.length ~/ 40) + 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: !_isSearching
                  ? Text('Поиск изображений')
                  : TextField(
                      decoration: InputDecoration(hintText: 'котики'),
                      controller: myTextController,
                    ),
              //TODO search bloc
              actions: [
                Padding(
                    padding: EdgeInsets.only(right: 1),
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        switch (_isSearching) {
                          case false:
                            setState(() {
                              _isSearching = true;
                            });
                            break;
                          case true:
                            setState(() {
                              _isSearching = false;
                              if (myTextController.text != '' || myTextController.text.isNotEmpty){
                                searchImages(myTextController.text);
                              }
                            });
                        }
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
                          changeColumnCount();
                          //TODO action
                        },
                      ))
              ],
            ),
            body: _isHome ? homePageWidget() : imageList(_images)));
  }

  Widget imageList(List<String> images) {
    //TODO bloc
    return RefreshIndicator(
        child: Scrollbar(
          child: GridView.builder(
              controller: scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _columnCount),
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Icon(Icons.error);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ImageFull(image: images[index])));
                    },
                  ),
                );
              }),
        ),
        onRefresh: refreshImages);
  }
}
