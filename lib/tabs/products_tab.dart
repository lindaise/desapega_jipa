import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>( // pega todos os doc e manda para categoty_tile.dart
      future: Firestore.instance.collection("anuncios").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {

          var dividedTiles = ListTile
              .divideTiles(context: context,                // arrumar o bug da v1.9
                  tiles: snapshot.data.documents.map((doc) { // pega cada doc e mapeia
                    return CategoryTile(doc);               // troca o doc por um categorytile
                  }).toList(),                              // e transforma em lista
                  color: Colors.grey[500])
              .toList();

          return ListView(
            children: dividedTiles,
          );

        }
      },
    );
  }
}
