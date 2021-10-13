// To parse this JSON data, do
//
//     final photosData = photosDataFromJson(jsonString);

import 'dart:convert';

PhotosData photosDataFromJson(String str) => PhotosData.fromJson(json.decode(str));

String photosDataToJson(PhotosData data) => json.encode(data.toJson());

class PhotosData {
  PhotosData({
    required this.photos,
    required this.stat,
  });

  Photos photos;
  String stat;

  factory PhotosData.fromJson(Map<String, dynamic> json) => PhotosData(
    photos: Photos.fromJson(json["photos"]),
    stat: json["stat"],
  );

  Map<String, dynamic> toJson() => {
    "photos": photos.toJson(),
    "stat": stat,
  };
}

class Photos {
  Photos({
    required this.page,
    required this.pages,
    required this.perpage,
    required this.total,
    required this.photo,
  });

  int page;
  int pages;
  int perpage;
  int total;
  List<Photo> photo;

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
    page: json["page"],
    pages: json["pages"],
    perpage: json["perpage"],
    total: json["total"],
    photo: List<Photo>.from(json["photo"].map((x) => Photo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "pages": pages,
    "perpage": perpage,
    "total": total,
    "photo": List<dynamic>.from(photo.map((x) => x.toJson())),
  };
}

class Photo {
  Photo({
    required this.id,
    required this.owner,
    required this.secret,
    required this.server,
    required this.farm,
    required this.title,
    required this.ispublic,
    required this.isfriend,
    required this.isfamily,
  });

  String id;
  String owner;
  String secret;
  String server;
  int farm;
  String title;
  int ispublic;
  int isfriend;
  int isfamily;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    id: json["id"],
    owner: json["owner"],
    secret: json["secret"],
    server: json["server"],
    farm: json["farm"],
    title: json["title"],
    ispublic: json["ispublic"],
    isfriend: json["isfriend"],
    isfamily: json["isfamily"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner": owner,
    "secret": secret,
    "server": server,
    "farm": farm,
    "title": title,
    "ispublic": ispublic,
    "isfriend": isfriend,
    "isfamily": isfamily,
  };
}
