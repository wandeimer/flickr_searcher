import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageFull extends StatefulWidget {
  final String image;
  const ImageFull({Key? key, required this.image}) : super(key: key);

  @override
  _ImageFullState createState() => _ImageFullState();
}

class _ImageFullState extends State<ImageFull> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_outline),
            onPressed: (){},
          )
        ],
      ),
      body: Center(
        child: Image.network(widget.image), //Image.asset('your_image_asset', width: 200, height: 200, fit: BoxFit.cover,
          ),
      );
  }
}
