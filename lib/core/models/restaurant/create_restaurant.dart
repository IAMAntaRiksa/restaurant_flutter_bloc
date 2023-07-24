// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateRestaurantModel {
  CreateData data;

  CreateRestaurantModel({
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'data': data,
    };
  }
}

class CreateData {
  final String name;
  final String description;
  final String latitude;
  final String longitude;
  final String address;
  final String? photo;
  final int? userId;

  CreateData({
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.address,
    this.photo,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'photo': photo,
      'userId': userId,
    };
  }

  CreateData copyWith({
    String? name,
    String? description,
    String? latitude,
    String? longitude,
    String? address,
    String? photo,
    int? userId,
  }) {
    return CreateData(
      name: name ?? this.name,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      photo: photo ?? this.photo,
      userId: userId ?? this.userId,
    );
  }
}
