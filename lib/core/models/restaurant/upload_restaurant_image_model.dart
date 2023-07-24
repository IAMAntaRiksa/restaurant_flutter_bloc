import 'package:flutter_caffe_ku/core/models/api/api_result_model.dart';

base class UploadRestaurantImageModel extends Serializable {
  final int id;
  final String name;
  final int width;
  final int height;
  final String urlImage;
  final FormatModel? format;

  UploadRestaurantImageModel({
    required this.id,
    required this.name,
    required this.width,
    required this.height,
    required this.urlImage,
    this.format,
  });

  factory UploadRestaurantImageModel.fromJson(Map<String, dynamic> json) {
    return UploadRestaurantImageModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      urlImage: json['url'] ?? "",
      format: json['formats'] != null
          ? FormatModel.fromJson(json['formats'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'width': width,
      'height': height,
      'url': urlImage,
      'formats': format,
    };
  }
}

base class FormatModel extends Serializable {
  Large? thumbnailResolution;
  Large? smallResolution;
  Large? mediumResolution;
  Large? largeResolution;

  FormatModel({
    this.thumbnailResolution,
    this.smallResolution,
    this.mediumResolution,
    this.largeResolution,
  });

  factory FormatModel.fromJson(Map<String, dynamic> json) {
    return FormatModel(
      thumbnailResolution:
          json['thumbnail'] != null ? Large.fromJson(json['thumbnail']) : null,
      smallResolution:
          json['small'] != null ? Large.fromJson(json['small']) : null,
      mediumResolution:
          json['medium'] != null ? Large.fromJson(json['medium']) : null,
      largeResolution:
          json['large'] != null ? Large.fromJson(json['large']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'thumbnail': thumbnailResolution,
      'small': smallResolution,
      'medium': mediumResolution,
      'large': largeResolution,
    };
  }
}

base class Large extends Serializable {
  final String name;
  final String hash;
  final String ext;
  final String mime;
  final String? path;
  final int width;
  final int height;
  final double size;
  final String url;

  Large({
    required this.name,
    required this.hash,
    required this.ext,
    required this.mime,
    this.path,
    required this.width,
    required this.height,
    required this.size,
    required this.url,
  });

  factory Large.fromJson(Map<String, dynamic> json) {
    return Large(
      name: json['name'],
      hash: json['hash'],
      ext: json['ext'],
      mime: json['mime'],
      width: json['width'],
      height: json['height'],
      size: json['size'],
      url: json['ext'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hash': hash,
      'ext': ext,
      'mime': mime,
      'width': width,
      'height': height,
      'size': size,
      'url': url,
    };
  }
}
