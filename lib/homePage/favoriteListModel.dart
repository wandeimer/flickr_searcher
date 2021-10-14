import 'favoriteListDatabase.dart';

class FavoriteListModel {
  List<String> _favoriteList;
  FavoriteListDatabase _database = FavoriteListDatabase();
  FavoriteListModel(this._favoriteList);


  void changeFavState(String imageLink) {
    if (_favoriteList.contains(imageLink)) {
      _favoriteList.remove(imageLink);
      _database.deleteImage(imageLink);
    }
    else {
      _favoriteList.add(imageLink);
      _database.addImage(imageLink);
    }
  }


  List<String> getList(){
    return _favoriteList;
  }

  Future<void> setList() async {
    _favoriteList = await _database.getAllImages();
  }
}