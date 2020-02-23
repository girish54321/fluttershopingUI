
import 'dart:convert';

class BanerResones {
  List<Baner> baners;

  BanerResones({
    this.baners,
  });

  factory BanerResones.fromJson(Map<String, dynamic> json) => BanerResones(
    baners: List<Baner>.from(json["baners"].map((x) => Baner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "baners": List<dynamic>.from(baners.map((x) => x.toJson())),
  };
}

class Baner {
  String imageUrl;
  String blurhash;

  Baner({
    this.imageUrl,
    this.blurhash,
  });

  factory Baner.fromJson(Map<String, dynamic> json) => Baner(
    imageUrl: json["image_url"],
    blurhash: json["blurhash"],
  );

  Map<String, dynamic> toJson() => {
    "image_url": imageUrl,
    "blurhash": blurhash,
  };
}
