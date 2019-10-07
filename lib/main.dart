 import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/cadastro_anuncio_screen.dart';
import 'package:loja_virtual/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                  title: "Desapega Jipa",
                  theme: ThemeData(
                      primarySwatch: Colors.teal, // cor da bolinha girando
                      //primaryColor: Color.fromARGB(255, 4, 100, 141)
                      primaryColor: Colors.teal,
                  ),
                  debugShowCheckedModeBanner: false, // não pular com o scroll
                  home: HomeScreen()
              ),
            );
          }
      ),
    );
  }
}
