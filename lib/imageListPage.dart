import 'package:flickr_searcher/imageFullPage.dart';
import 'package:flutter/material.dart';

Widget imageList(List<String> images) {
  //TODO bloc
  return RefreshIndicator(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ImageFull(image: images[index])));
                },
              ),
            );
          }),
      onRefresh: _getData);
}
Future<void> _getData() async {
  //TODO block refresh
  Future.delayed(Duration(seconds: 3));
}