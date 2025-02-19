import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/login/user_model.dart';
import 'package:loja_virtual/screens/cart_screen.dart';
import 'package:loja_virtual/login/login_screen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:flutter_launch/flutter_launch.dart';

class ProductScreen extends StatefulWidget {

  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}



class _ProductScreenState extends State<ProductScreen> {

  final ProductData product;

  String it_works;
  String phone;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {

    //final _userData = UserData;

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor
                  ),
                ),
                SizedBox(height: 16.0,),



                Text(
                  "Descrição",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                      fontSize: 16.0
                  ),
                ),
                SizedBox(height: 16.0,),

                Text(
                  "Estado do Produto",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500
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
                        childAspectRatio: 0.2
                    ),
                    children: product.it_works.map(
                            (s){
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                it_works = s;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                  border: Border.all(
                                      color: s == it_works ? primaryColor : Colors.grey[500],
                                      width: 3.0
                                  )
                              ),
                              width: 50.0,
                              alignment: Alignment.center,
                              child: Text(s),
                            ),
                          );
                        }
                    ).toList(),
                  ),
                ),
                SizedBox(height: 16.0,),
                /*SizedBox( // ---------------- botao adicionar
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: it_works != null ?
                    (){
                      if(UserModel.of(context).isLoggedIn()){

                        CartProduct cartProduct = CartProduct();
                        cartProduct.it_works = it_works;
                        cartProduct.quantity = 1;
                        cartProduct.pid = product.id;
                        cartProduct.category = product.category;
                        cartProduct.productData = product;

                        CartModel.of(context).addCartItem(cartProduct);

                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>CartScreen())
                        );

                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginScreen())
                        );
                      }
                    } : null,
                    child: Text(UserModel.of(context).isLoggedIn() ? "Adicionar Anúncio"
                      : "Entre para Criar o Anúncio",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),*/

              ],
            ),
          )
        ],
      ),
      floatingActionButton: _buildFloating(),
    );
  }

  Widget _buildFloating(){
    //child: ScopedModelDescendant<UserModel>(
        //builder: (context, child, model){
        return SpeedDial(
          child: Icon(Icons.touch_app),
          backgroundColor: Colors.teal,
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
                child: Icon(Icons.call, color: Colors.teal,),
                backgroundColor: Colors.white,
                label: "Ligar",
                labelStyle: TextStyle(fontSize: 14),
                onTap: (){
                  //_ordersBloc.setOrderCriteria(SortCriteria.READY_LAST);
                  //launch("tel:${ads[index].phone}");
                  launch("tel:${UserModel.of(context).userData["phone"]}");
                }
            ),
            SpeedDialChild(
                child: Icon(Icons.chat, color: Colors.teal,),
                backgroundColor: Colors.white,
                label: "WhatsApp",
                labelStyle: TextStyle(fontSize: 14),
                onTap: () async {
                 // _ordersBloc.setOrderCriteria(SortCriteria.READY_FIRST);
                  //whatsAppOpen();
                  var whatsappUrl ="whatsapp://send?phone=+${UserModel.of(context).userData["phone"]}&text="
                      "Olá,%20meu%20amigo!%20Vi%20seu%20anúncio:%20${product.title}%20no%20DesapegaJipa";

                  await canLaunch(whatsappUrl)?
                  launch(whatsappUrl):print("Não há WhatsApp instalado");

                }
            )
          ],
        );
       // },
    //);
  }

}
