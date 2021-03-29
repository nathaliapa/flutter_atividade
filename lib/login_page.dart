import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import 'package:flutter_atividade/api_response.dart';
import 'package:flutter_atividade/firebases/firebase_service.dart';
import 'package:flutter_atividade/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("meu app"),
      ),
      body: _body(context),
    );
  }
}

_body(context){
  return Form(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'Nome'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: TextField(
                decoration: InputDecoration(labelText: "senha"),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 16.0),
              child: GoogleSignInButton(
                text: 'Sign in with Google',
                onPressed: () async{
                  final service = FirebaseService();
                  ApiResponse response = await service.loginGoogle();
                  if(response.ok){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => HomePage()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      )
  );
}
