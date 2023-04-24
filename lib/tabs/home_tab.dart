import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/async.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(239, 42, 112, 103),
                Color.fromARGB(238, 109, 155, 149),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
    final _size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        Container(
          height: _size.height,
          width: double.infinity,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text("Novidades"),
                  centerTitle: true,
                ),
              ),
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection("home")
                    //.orderBy("pos")
                    .get(),
                builder: (context, snaspshot) {
                  if (!snaspshot.hasData)
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  else {
                    return SliverStaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      staggeredTiles: snaspshot.data?.docs.map(
                            (doc) {
                              //Map<String, dynamic> jhon =
                              //    doc.data() as Map<String, dynamic>;
                              return StaggeredTile.count(
                                int.parse(doc["x"].toString()),
                                double.parse(doc["y"].toString()),
                              );
                            },
                          ).toList() ??
                          [],
                      children: snaspshot.data?.docs.map((doc) {
                            return FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: doc["image"].toString(),
                              fit: BoxFit.cover,
                            );
                          }).toList() ??
                          [],
                    );

                    /* print(snaspshot.data!.docs.length);
                    //print(snaspshot.data.documents.length);
                    //print(snaspshot.data<DocumentSnapshot>.data["home"]);
                    */
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
