import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal,
            Colors.tealAccent
          ],
          begin: Alignment.topLeft, //onde o gradiente começa
          end: Alignment.bottomRight //onde o gradiente termina
        )
      ),
    );

    return Stack( // colocar uma coisa em cima da outra ou é um retangulo
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView( //
          slivers: <Widget>[
            SliverAppBar( // appbar flutuante que vai sumindo
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Início"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>( // pega todos os doc da coleção home no Firebase e ordenando pela pos
              future: Firestore.instance
                .collection("home").orderBy("pos").getDocuments(),
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  return SliverToBoxAdapter( // botão aguarde carregando
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                else
                  return SliverStaggeredGrid.count(
                      crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    staggeredTiles: snapshot.data.documents.map(
                      (doc){
                        return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                      }
                    ).toList(),
                    children: snapshot.data.documents.map(
                      (doc){
                        return FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: doc.data["image"],
                            fit: BoxFit.cover,
                        );
                      }
                    ).toList(),
                  );
              },
            )
          ],
        )
      ],
    );
  }
}
