import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';

class DiscountCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Cupom de desconto",
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom",
              ),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                FirebaseFirestore.instance
                    .collection("coupons")
                    .doc(text)
                    .get()
                    .then((docSnap) {
                  if (docSnap != null) {
                    CartModel.of(context).setCoupon(text, docSnap["percent"]);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Desconto de ${docSnap["percent"]}% aplicado!",
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ));
                  } else {
                    CartModel.of(context).setCoupon(null, 0);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Cupom não existente!",
                      ),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
