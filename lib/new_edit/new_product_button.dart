import 'package:flutter/material.dart';
import 'package:loja_virtual/new_edit/products_tab.dart';

class NewProductButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: (){
       /* Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>CartScreen())
        );*/
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>ProductsTab())
          );


      },
      icon: Icon(Icons.add),
      label: Text("Desapegar"),
      backgroundColor: Theme.of(context).primaryColor,

    );

  }
}
