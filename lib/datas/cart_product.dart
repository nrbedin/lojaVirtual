import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/datas/product_data.dart';

class CartProduct {
  late String cid;

  late String category;
  late String pid;
  late int quantity;
  late String flavor;

  ProductData? productData;
  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.id;
    category = document["category"];
    pid = document["pid"];
    quantity = document["quantity"];
    flavor = document["flavor"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "flavor": flavor,
      "product": productData?.toResumedMap()
    };
  }
}
