import 'dart:convert';

class VendorModel {
  final String id;
  final String username;
  final String email;
  final String city;
  final String state;
  final String locality;
  final String role;
  final String password;

  VendorModel(
      {required this.id,
      required this.username,
      required this.email,
      required this.city,
      required this.state,
      required this.locality,
      required this.role,
      required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'city': city,
      'state': state,
      'locality': locality,
      'role': role,
      'password': password
    };
  }

  String toJson() => json.encode(toMap());

  factory VendorModel.fromMap(Map<String, dynamic> map) {
    return VendorModel(
      id: map['_id'] as String? ?? '',
      username: map['username'] as String? ?? '',
      email: map['email'] as String? ?? '',
      city: map['city'] as String? ?? '',
      state: map['state'] as String? ?? '',
      locality: map['locality'] as String? ?? '',
      role: map['role'],
      password: map['password'] as String? ?? '',
    );
  }

  /*
  factory VendorModel.fromJson(String source) =>
      VendorModel.fromMap(json.decode(source) as Map<String, dynamic>);
   */
}