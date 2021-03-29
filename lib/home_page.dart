import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_atividade/firebases/firebase_service.dart';
import 'package:flutter_atividade/login_page.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    Future<FirebaseUser> future = FirebaseAuth.instance.currentUser();

    return Scaffold(
      appBar: AppBar(
        title: Text('meu app'),
      ),
      drawer: Drawer(
        child: ListView(
          children:<Widget> [
            FutureBuilder<FirebaseUser>(
              future: future,
              builder: (context, snapshot) {
                FirebaseUser user = snapshot.data;
                return UserAccountsDrawerHeader(
                  accountName: Text(user.displayName ?? ""),
                  accountEmail: Text(user.email),
                  currentAccountPicture: user.photoUrl != null
                      ? CircleAvatar(
                    backgroundImage: NetworkImage(user.photoUrl),)
                      : FlutterLogo(),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app,),
              title: Text('Sair'),
              onTap: () => _onClickLogout(context),
            ),
          ],
        ),
      ),
      body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
             PaginatedDataTable(
                header: Text('Titulo'),
                rowsPerPage: 2,
                columns: [
                  DataColumn(
                    label: Text('Primeiro Nome')),
                 DataColumn(
                   label: Text('Segundo Nome')),
                ],
          ),
    // ignore: deprecated_member_use
            RaisedButton(
             color: Colors.amberAccent,
              onPressed: (){
                 Navigator.pop(context);
                },
              child: Text("Retornar"),
          ),
        ],
      ),
    );
}


_onClickLogout(BuildContext context) {
  FirebaseService().logout();
  Navigator.pop(context);
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => LoginPage()),
  );
}
}