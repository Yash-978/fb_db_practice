class ImageUploadModal {
  int status;
  bool success;
  Data data;

  ImageUploadModal({
    required this.status,
    required this.success,
    required this.data,
  });

  factory ImageUploadModal.fromMap(Map json){
    return ImageUploadModal(
      status: json["status"],
      success: json["success"],
      data: Data.fromMap(json["data"]),
    );
  }


  Map<String, dynamic> toMap() => {
        "status": status,
        "success": success,
        "data": data.toMap(),
      };
}

class Data {
  String id;
  String deletehash;
  dynamic accountId;
  dynamic accountUrl;
  dynamic adType;
  dynamic adUrl;
  String title;
  String description;
  String name;
  String type;
  int width;
  int height;
  int size;
  int views;
  dynamic section;
  dynamic vote;
  int bandwidth;
  bool animated;
  bool favorite;
  bool inGallery;
  bool inMostViral;
  bool hasSound;
  bool isAd;
  dynamic nsfw;
  String link;
  List<dynamic> tags;
  int datetime;
  String mp4;
  String hls;

  Data({
    required this.id,
    required this.deletehash,
    required this.accountId,
    required this.accountUrl,
    required this.adType,
    required this.adUrl,
    required this.title,
    required this.description,
    required this.name,
    required this.type,
    required this.width,
    required this.height,
    required this.size,
    required this.views,
    required this.section,
    required this.vote,
    required this.bandwidth,
    required this.animated,
    required this.favorite,
    required this.inGallery,
    required this.inMostViral,
    required this.hasSound,
    required this.isAd,
    required this.nsfw,
    required this.link,
    required this.tags,
    required this.datetime,
    required this.mp4,
    required this.hls,
  });

  factory Data.fromMap(Map json) => Data(
        id: json["id"],
        deletehash: json["deletehash"],
        accountId: json["account_id"],
        accountUrl: json["account_url"],
        adType: json["ad_type"],
        adUrl: json["ad_url"],
        title: json["title"],
        description: json["description"],
        name: json["name"],
        type: json["type"],
        width: json["width"],
        height: json["height"],
        size: json["size"],
        views: json["views"],
        section: json["section"],
        vote: json["vote"],
        bandwidth: json["bandwidth"],
        animated: json["animated"],
        favorite: json["favorite"],
        inGallery: json["in_gallery"],
        inMostViral: json["in_most_viral"],
        hasSound: json["has_sound"],
        isAd: json["is_ad"],
        nsfw: json["nsfw"],
        link: json["link"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        datetime: json["datetime"],
        mp4: json["mp4"],
        hls: json["hls"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "deletehash": deletehash,
        "account_id": accountId,
        "account_url": accountUrl,
        "ad_type": adType,
        "ad_url": adUrl,
        "title": title,
        "description": description,
        "name": name,
        "type": type,
        "width": width,
        "height": height,
        "size": size,
        "views": views,
        "section": section,
        "vote": vote,
        "bandwidth": bandwidth,
        "animated": animated,
        "favorite": favorite,
        "in_gallery": inGallery,
        "in_most_viral": inMostViral,
        "has_sound": hasSound,
        "is_ad": isAd,
        "nsfw": nsfw,
        "link": link,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "datetime": datetime,
        "mp4": mp4,
        "hls": hls,
      };
}
