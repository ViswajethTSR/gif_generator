import 'dart:convert';

GifGeneratorModel welcomeFromJson(String str) => GifGeneratorModel.fromJson(json.decode(str));

String welcomeToJson(GifGeneratorModel data) => json.encode(data.toJson());

class GifGeneratorModel {
  List<Datum>? data;
  Meta? meta;
  Pagination? pagination;

  GifGeneratorModel({
    this.data,
    this.meta,
    this.pagination,
  });

  factory GifGeneratorModel.fromJson(Map<String, dynamic> json) => GifGeneratorModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
        "pagination": pagination?.toJson(),
      };
}

class Datum {
  Type? type;
  String? id;
  String? url;
  String? slug;
  String? bitlyGifUrl;
  String? bitlyUrl;
  String? embedUrl;
  String? username;
  String? source;
  String? title;
  Rating? rating;
  String? contentUrl;
  String? sourceTld;
  String? sourcePostUrl;
  int? isSticker;
  DateTime? importDatetime;
  dynamic trendingDatetime;
  Images? images;
  User? user;
  String? analyticsResponsePayload;
  Analytics? analytics;
  String? altText;

  Datum({
    this.type,
    this.id,
    this.url,
    this.slug,
    this.bitlyGifUrl,
    this.bitlyUrl,
    this.embedUrl,
    this.username,
    this.source,
    this.title,
    this.rating,
    this.contentUrl,
    this.sourceTld,
    this.sourcePostUrl,
    this.isSticker,
    this.importDatetime,
    this.trendingDatetime,
    this.images,
    this.user,
    this.analyticsResponsePayload,
    this.analytics,
    this.altText,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: typeValues.map[json["type"]]!,
        id: json["id"],
        url: json["url"],
        slug: json["slug"],
        bitlyGifUrl: json["bitly_gif_url"],
        bitlyUrl: json["bitly_url"],
        embedUrl: json["embed_url"],
        username: json["username"],
        source: json["source"],
        title: json["title"],
        rating: ratingValues.map[json["rating"]]!,
        contentUrl: json["content_url"],
        sourceTld: json["source_tld"],
        sourcePostUrl: json["source_post_url"],
        isSticker: json["is_sticker"],
        importDatetime: json["import_datetime"] == null ? null : DateTime.parse(json["import_datetime"]),
        trendingDatetime: json["trending_datetime"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        analyticsResponsePayload: json["analytics_response_payload"],
        analytics: json["analytics"] == null ? null : Analytics.fromJson(json["analytics"]),
        altText: json["alt_text"],
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "id": id,
        "url": url,
        "slug": slug,
        "bitly_gif_url": bitlyGifUrl,
        "bitly_url": bitlyUrl,
        "embed_url": embedUrl,
        "username": username,
        "source": source,
        "title": title,
        "rating": ratingValues.reverse[rating],
        "content_url": contentUrl,
        "source_tld": sourceTld,
        "source_post_url": sourcePostUrl,
        "is_sticker": isSticker,
        "import_datetime": importDatetime?.toIso8601String(),
        "trending_datetime": trendingDatetime,
        "images": images?.toJson(),
        "user": user?.toJson(),
        "analytics_response_payload": analyticsResponsePayload,
        "analytics": analytics?.toJson(),
        "alt_text": altText,
      };
}

class Analytics {
  Onclick? onload;
  Onclick? onclick;
  Onclick? onsent;

  Analytics({
    this.onload,
    this.onclick,
    this.onsent,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) => Analytics(
        onload: json["onload"] == null ? null : Onclick.fromJson(json["onload"]),
        onclick: json["onclick"] == null ? null : Onclick.fromJson(json["onclick"]),
        onsent: json["onsent"] == null ? null : Onclick.fromJson(json["onsent"]),
      );

  Map<String, dynamic> toJson() => {
        "onload": onload?.toJson(),
        "onclick": onclick?.toJson(),
        "onsent": onsent?.toJson(),
      };
}

class Onclick {
  String? url;

  Onclick({
    this.url,
  });

  factory Onclick.fromJson(Map<String, dynamic> json) => Onclick(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Images {
  FixedHeight? original;
  FixedHeight? fixedHeight;
  FixedHeight? fixedHeightDownsampled;
  FixedHeight? fixedHeightSmall;
  FixedHeight? fixedWidth;
  FixedHeight? fixedWidthDownsampled;
  FixedHeight? fixedWidthSmall;

  Images({
    this.original,
    this.fixedHeight,
    this.fixedHeightDownsampled,
    this.fixedHeightSmall,
    this.fixedWidth,
    this.fixedWidthDownsampled,
    this.fixedWidthSmall,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        original: json["original"] == null ? null : FixedHeight.fromJson(json["original"]),
        fixedHeight: json["fixed_height"] == null ? null : FixedHeight.fromJson(json["fixed_height"]),
        fixedHeightDownsampled: json["fixed_height_downsampled"] == null ? null : FixedHeight.fromJson(json["fixed_height_downsampled"]),
        fixedHeightSmall: json["fixed_height_small"] == null ? null : FixedHeight.fromJson(json["fixed_height_small"]),
        fixedWidth: json["fixed_width"] == null ? null : FixedHeight.fromJson(json["fixed_width"]),
        fixedWidthDownsampled: json["fixed_width_downsampled"] == null ? null : FixedHeight.fromJson(json["fixed_width_downsampled"]),
        fixedWidthSmall: json["fixed_width_small"] == null ? null : FixedHeight.fromJson(json["fixed_width_small"]),
      );

  Map<String, dynamic> toJson() => {
        "original": original?.toJson(),
        "fixed_height": fixedHeight?.toJson(),
        "fixed_height_downsampled": fixedHeightDownsampled?.toJson(),
        "fixed_height_small": fixedHeightSmall?.toJson(),
        "fixed_width": fixedWidth?.toJson(),
        "fixed_width_downsampled": fixedWidthDownsampled?.toJson(),
        "fixed_width_small": fixedWidthSmall?.toJson(),
      };
}

class FixedHeight {
  String? height;
  String? width;
  String? size;
  String? url;
  String? mp4Size;
  String? mp4;
  String? webpSize;
  String? webp;
  String? frames;
  String? hash;

  FixedHeight({
    this.height,
    this.width,
    this.size,
    this.url,
    this.mp4Size,
    this.mp4,
    this.webpSize,
    this.webp,
    this.frames,
    this.hash,
  });

  factory FixedHeight.fromJson(Map<String, dynamic> json) => FixedHeight(
        height: json["height"],
        width: json["width"],
        size: json["size"],
        url: json["url"],
        mp4Size: json["mp4_size"],
        mp4: json["mp4"],
        webpSize: json["webp_size"],
        webp: json["webp"],
        frames: json["frames"],
        hash: json["hash"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "width": width,
        "size": size,
        "url": url,
        "mp4_size": mp4Size,
        "mp4": mp4,
        "webp_size": webpSize,
        "webp": webp,
        "frames": frames,
        "hash": hash,
      };
}

enum Rating { G }

final ratingValues = EnumValues({"g": Rating.G});

enum TrendingDatetimeEnum { THE_00000000000000 }

final trendingDatetimeEnumValues = EnumValues({"0000-00-00 00:00:00": TrendingDatetimeEnum.THE_00000000000000});

enum Type { GIF }

final typeValues = EnumValues({"gif": Type.GIF});

class User {
  String? avatarUrl;
  String? bannerImage;
  String? bannerUrl;
  String? profileUrl;
  String? username;
  String? displayName;
  String? description;
  String? instagramUrl;
  String? websiteUrl;
  bool? isVerified;

  User({
    this.avatarUrl,
    this.bannerImage,
    this.bannerUrl,
    this.profileUrl,
    this.username,
    this.displayName,
    this.description,
    this.instagramUrl,
    this.websiteUrl,
    this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatarUrl: json["avatar_url"],
        bannerImage: json["banner_image"],
        bannerUrl: json["banner_url"],
        profileUrl: json["profile_url"],
        username: json["username"],
        displayName: json["display_name"],
        description: json["description"],
        instagramUrl: json["instagram_url"],
        websiteUrl: json["website_url"],
        isVerified: json["is_verified"],
      );

  Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl,
        "banner_image": bannerImage,
        "banner_url": bannerUrl,
        "profile_url": profileUrl,
        "username": username,
        "display_name": displayName,
        "description": description,
        "instagram_url": instagramUrl,
        "website_url": websiteUrl,
        "is_verified": isVerified,
      };
}

class Meta {
  int? status;
  String? msg;
  String? responseId;

  Meta({
    this.status,
    this.msg,
    this.responseId,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        status: json["status"],
        msg: json["msg"],
        responseId: json["response_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "response_id": responseId,
      };
}

class Pagination {
  int? totalCount;
  int? count;
  int? offset;

  Pagination({
    this.totalCount,
    this.count,
    this.offset,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalCount: json["total_count"],
        count: json["count"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "total_count": totalCount,
        "count": count,
        "offset": offset,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
