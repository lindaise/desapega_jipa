import 'package:flutter/material.dart';
import 'package:loja_virtual/login/user_model.dart';
import 'package:loja_virtual/login/login_screen.dart';

import 'package:scoped_model/scoped_model.dart';

import 'drawer_tile.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.teal,
                Colors.grey[850]
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),

          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[

                    Positioned(
                      top: 28.0,
                      left: 0.0,
                      child: Text("DESAPEGAJIPA",
                        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),

                      ),

                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox (height: 8.0,),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn() ?
                                  "Entre ou Cadastre-se >"
                                  : "Sair",
                                  style: TextStyle(
                                      //color: Theme.of(context).primaryColor,
                                      color: Colors.tealAccent,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                onTap: (){
                                  if(!model.isLoggedIn())
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>LoginScreen())

                                    );

                                  else
                                    model.signOut();
                                  },
                              )
                            ],
                          );
                        },
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.list, "Categorias", pageController, 1),
              DrawerTile(Icons.playlist_add_check, "Meus Anúncios", pageController, 2),
              DrawerTile(Icons.location_on, "Locais de Descarte", pageController, 3),

            ],
          )
        ],
      ),
    );
  }
}
