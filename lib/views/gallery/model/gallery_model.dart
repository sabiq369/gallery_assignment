// To parse this JSON data, do
//
//     final galleryModel = galleryModelFromJson(jsonString);

import 'dart:convert';

GalleryModel galleryModelFromJson(String str) =>
    GalleryModel.fromJson(json.decode(str));

String galleryModelToJson(GalleryModel data) => json.encode(data.toJson());

class GalleryModel {
  final int total;
  final int totalHits;
  final List<Hit> hits;

  GalleryModel({
    required this.total,
    required this.totalHits,
    required this.hits,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
        total: json["total"] ?? 0,
        totalHits: json["totalHits"] ?? 0,
        hits: json["hits"] == null
            ? []
            : List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "totalHits": totalHits,
        "hits": List<dynamic>.from(hits.map((x) => x.toJson())),
      };
}

class Hit {
  final int id;
  final String pageUrl;
  final Type type;
  final String tags;
  final String previewUrl;
  final int previewWidth;
  final int previewHeight;
  final String webformatUrl;
  final int webformatWidth;
  final int webformatHeight;
  final String largeImageUrl;
  final int imageWidth;
  final int imageHeight;
  final int imageSize;
  final int views;
  final int downloads;
  final int collections;
  final int likes;
  final int comments;
  final int userId;
  final String user;
  final String userImageUrl;

  Hit({
    required this.id,
    required this.pageUrl,
    required this.type,
    required this.tags,
    required this.previewUrl,
    required this.previewWidth,
    required this.previewHeight,
    required this.webformatUrl,
    required this.webformatWidth,
    required this.webformatHeight,
    required this.largeImageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageSize,
    required this.views,
    required this.downloads,
    required this.collections,
    required this.likes,
    required this.comments,
    required this.userId,
    required this.user,
    required this.userImageUrl,
  });

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        id: json["id"] ?? 0,
        pageUrl: json["pageURL"] ?? '',
        type: typeValues.map[json["type"]]!,
        tags: json["tags"] ?? '',
        previewUrl: json["previewURL"] ?? '',
        previewWidth: json["previewWidth"] ?? 0,
        previewHeight: json["previewHeight"] ?? 0,
        webformatUrl: json["webformatURL"] ?? '',
        webformatWidth: json["webformatWidth"] ?? 0,
        webformatHeight: json["webformatHeight"] ?? 0,
        largeImageUrl: json["largeImageURL"] ?? '',
        imageWidth: json["imageWidth"] ?? 0,
        imageHeight: json["imageHeight"] ?? 0,
        imageSize: json["imageSize"] ?? 0,
        views: json["views"] ?? 0,
        downloads: json["downloads"] ?? 0,
        collections: json["collections"] ?? 0,
        likes: json["likes"] ?? 0,
        comments: json["comments"] ?? 0,
        userId: json["user_id"] ?? 0,
        user: json["user"] ?? '',
        userImageUrl: json["userImageURL"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pageURL": pageUrl,
        "type": typeValues.reverse[type],
        "tags": tags,
        "previewURL": previewUrl,
        "previewWidth": previewWidth,
        "previewHeight": previewHeight,
        "webformatURL": webformatUrl,
        "webformatWidth": webformatWidth,
        "webformatHeight": webformatHeight,
        "largeImageURL": largeImageUrl,
        "imageWidth": imageWidth,
        "imageHeight": imageHeight,
        "imageSize": imageSize,
        "views": views,
        "downloads": downloads,
        "collections": collections,
        "likes": likes,
        "comments": comments,
        "user_id": userId,
        "user": user,
        "userImageURL": userImageUrl,
      };
}

enum Type { PHOTO }

final typeValues = EnumValues({"photo": Type.PHOTO});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
