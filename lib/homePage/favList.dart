class FavList {
  List<String> _favoriteList;
  FavList(this._favoriteList);

  void changeFavState(String imageLink) {
    bool yaNePonyal = _favoriteList.contains(imageLink);
    if (yaNePonyal) {
      _favoriteList.remove(imageLink);
    }
    else {
      _favoriteList.add(imageLink);
    }
  }

  List<String> getList(){
    return _favoriteList;
  }
}