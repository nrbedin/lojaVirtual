import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  late List flavors;
  late String id;
  late String title;
  late String description;
  late double price;
  late List images;

  static String? category;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    title = snapshot["title"].toString();
    description = snapshot["description"].toString();
    price = double.tryParse(snapshot["price"].toString()) ?? 0;
    images = snapshot["images"] ?? [];
    flavors = snapshot["flavors"] ?? [];
  }

  Map<String, dynamic> toResumedMap() {
    return {
      "title": title,
      "description": description,
      "price": price,
    };
  }
}
