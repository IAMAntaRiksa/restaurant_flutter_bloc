// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_caffe_ku/core/models/api/api_result_model.dart';
import 'package:flutter_caffe_ku/core/models/attribute/atribute_model.dart';

base class RestaurantModel extends Serializable {
  final int id;
  final AttributeModel? attributes;

  RestaurantModel({
    required this.id,
    required this.attributes,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] ?? "",
      attributes: json['attributes'] != null
          ? AttributeModel.fromJson(json['attributes'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "attributes": attributes,
    };
  }
}
