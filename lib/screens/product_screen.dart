//import 'dart:io';

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:lojavirtual/datas/cart_product.dart';
import 'package:lojavirtual/datas/product_data.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/cart_screen.dart';
import 'package:lojavirtual/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;

  //String flav;
  String? flav;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
              ),
              items: product.images
                  .map(
                    (url) => Image.network(url, fit: BoxFit.cover),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Sabor",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.3,
                    ),
                    children: product.flavors.map((flavor) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            flav = flavor;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                4.0,
                              ),
                            ),
                            border: Border.all(
                              color:
                                  flavor == flav ? primaryColor : Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(flavor),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                    onPressed: flav != null
                        ? () {
                            if (UserModel.of(context).isLoggedIn()) {
                              //add ao carrinho
                              CartProduct cartProduct = CartProduct();
                              cartProduct.flavor = flav!;
                              cartProduct.quantity = 1;
                              cartProduct.pid = product.id;
                              cartProduct.category = ProductData.category!;
                              cartProduct.productData = product;

                              CartModel.of(context).addCartItem(cartProduct);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CartScreen()));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            }
                          }
                        : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn()
                          ? "Adicionar ao carrinho"
                          : "Entre para comprar",
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Descrição",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
