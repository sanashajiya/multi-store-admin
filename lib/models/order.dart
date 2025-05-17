import 'dart:convert';

class OrderModel {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String productName;
  final int productPrice;
  final int quantity;
  final String category;
  final String image;
  final String buyerId;
  final String vendorId;
  final bool processing;
  final bool delivered;
  //final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.category,
    required this.image,
    required this.buyerId,
    required this.vendorId,
    required this.processing,
    required this.delivered,
    //required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'category': category,
      'image': image,
      'buyerId': buyerId,
      'vendorId': vendorId,
      'processing': processing,
      'delivered': delivered,
      //'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(Map<String, dynamic> map) {
    return OrderModel(
      id: map['_id']  ?? '',
      fullName: map['fullName']  ?? "Unknown Name",
      email: map['email']  ?? '',
      state: map['state']  ?? '',
      city: map['city']  ?? '',
      locality: map['locality']  ?? '',
      productName: map['productName']  ?? '',
      productPrice: map['productPrice']  ?? 0,
      quantity: map['quantity'] ?? 0,
      category: map['category']  ?? '',
      image: map['image']  ?? '',
      buyerId: map['buyerId']  ?? '',
      vendorId: map['vendorId']  ?? '',
      processing: map['processing']  ?? true,
      delivered: map['delivered']  ?? false,
      //createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

/*
  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

   */
}