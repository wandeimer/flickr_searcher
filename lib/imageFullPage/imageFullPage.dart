import 'package:flickr_searcher/homePage/favoriteListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageFull extends StatefulWidget {
  final String image;
  final FavoriteListModel favorite;
  const ImageFull({Key? key, required this.image, required this.favorite}) : super(key: key);

  @override
  _ImageFullState createState() => _ImageFullState();
}

class _ImageFullState extends State<ImageFull> {
  bool _isFavorite = false;
  List<String> favoriteList = [];
  @override
  void initState() {
    favoriteList = widget.favorite.getList();
    if (favoriteList.contains(widget.image))
       _isFavorite = true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: _isFavorite
                ? Icon(Icons.bookmark)
                : Icon(Icons.bookmark_outline),
            onPressed: () {
              setState(() {
                widget.favorite.changeFavState(widget.image);
                _isFavorite = !_isFavorite;
                favoriteList = widget.favorite.getList();
              });
            },
          )
        ],
      ),
      body: Center(
        child: Image.network(
          widget.image,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Icon(Icons.error);
          },
        ), //Image.asset('your_image_asset', width: 200, height: 200, fit: BoxFit.cover,
      ),
    );
  }
}
