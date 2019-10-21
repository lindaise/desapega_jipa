import 'package:flutter/material.dart';
import 'package:loja_virtual/login/user_model.dart';
import 'package:loja_virtual/login/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(child: CircularProgressIndicator(),);

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset("images/logo.png"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    icon: Icon(Icons.person_outline),
                    hintText: "E-mail"
                ),

                keyboardType: TextInputType.emailAddress,
                validator: (text) {
                  if (text.isEmpty || !text.contains("@"))
                    return "E-mail inválido!";
                },
              ),
              SizedBox(height: 16.0,),
              TextFormField(
                controller: _passController,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline),
                    hintText: "Senha"
                ),
                obscureText: true,
                validator: (text) {
                  if (text.isEmpty || text.length < 6) return "Senha inválida!";
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {
                    if (_emailController.text.isEmpty)
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text(
                              "Insira seu e-mail para recuperação!"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          )
                      );
                    else {
                      model.recoverPass(_emailController.text);
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text("Confira seu e-mail!"),
                            backgroundColor: Theme
                                .of(context)
                                .primaryColor,
                            duration: Duration(seconds: 2),
                          )
                      );
                    }
                  },
                  child: Text("Esqueceu a senha?",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),

                  padding: EdgeInsets.zero,
                ),
              ),
              SizedBox(height: 16.0,),
              SizedBox(
                height: 44.0,
                child: RaisedButton(
                  child: Text("Entrar",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {

                    }
                    model.signIn(
                        email: _emailController.text,
                        pass: _passController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail
                    );
                  },
                ),
              ),
              SizedBox(height: 16.0,),
              Divider(),
              Row(

                crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 SizedBox (width: 30.0,),
                Text(
                  "Ainda não é cadastrado?",

                  style: TextStyle(fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),

                ),
                 SizedBox (width: 8.0,),
              GestureDetector(

                  child: Text("Cadastre-se",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignUpScreen())
                  );
                },
              )
                ],
              ),
            ]
            ,
            )
            ,
            );
          },
        )
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao Entrar!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

}
