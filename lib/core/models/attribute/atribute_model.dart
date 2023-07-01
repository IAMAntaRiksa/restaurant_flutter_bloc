// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_caffe_ku/core/models/api/api_result_model.dart';

base class AttributeModel extends Serializable {
  final String name;
  final String description;
  final String latitude;
  final String longitude;
  final String address;
  final String photo;
  final String userId;

  AttributeModel({
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.photo,
    required this.userId,
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) {
    return AttributeModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      address: json['address'] ?? '',
      photo: json['photo'] ?? '',
      userId: json['userId'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "photo": photo,
        "userId": userId,
      };
}
