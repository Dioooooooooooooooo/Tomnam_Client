import 'dart:core';

class Karenderya {
  final String Id;
  final String ownerId;
  final String name;
  final String locationStreet;
  final String locationBarangay;
  final String locationCity;
  final String locationProvince;
  final DateTime dateFounded;
  final String? description;
  final String? logoPhoto;
  final String? coverPhoto;
  final double? rating;
  final bool isVerified;

  Karenderya({
    required this.Id,
    required this.ownerId,
    required this.name,
    required this.locationStreet,
    required this.locationBarangay,
    required this.locationCity,
    required this.locationProvince,
    required this.dateFounded,
    this.description,
    this.logoPhoto,
    this.coverPhoto,
    this.rating,
    required this.isVerified
  });

  factory Karenderya.fromJson(Map<String, dynamic> json) {
    return Karenderya(
      Id: json['id'] as String,
      ownerId: json['userId'] as String,
      name: json['name'] as String,
      locationStreet: json['locationStreet'] as String,
      locationBarangay: json['locationBarangay'] as String,
      locationCity: json['locationCity'] as String,
      locationProvince: json['locationProvince'] as String,
      dateFounded: DateTime.parse(json['dateFounded'] as String),
      description: json['description'] as String?,
      logoPhoto: json['logoPhoto'] as String?,
      coverPhoto: json['coverPhoto'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      isVerified: json['isVerified'] as bool
    );
  }
}