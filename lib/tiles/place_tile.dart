import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  PlaceTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 270.0,
            child: Image.asset(
              'assets/icons/fundo.png',
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Empresa NR',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                Text(
                  'Rua André Felipe, 50',
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  //launchUrlString(
                  //    "https://www.google.com/maps/search/?api=1&query=${snapshot["lat"]},"
                  //    "${snapshot["long"]}");
                },
                child: Text(
                  "Ver no Mapa",
                  // style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(width: 18.0),
              Padding(padding: EdgeInsets.zero),
              ElevatedButton(
                onPressed: () {
                  // launchUrlString("tel: ${snapshot["phone"]}");
                },
                child: Text(
                  "Ligar",
                  //style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
              Padding(padding: EdgeInsets.all(8.0)),
            ],
          )
        ],
      ),
    );
  }
}
