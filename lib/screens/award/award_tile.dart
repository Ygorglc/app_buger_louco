import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:hamburgueria/screens/category_screen.dart';

class AwardTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  AwardTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //define o icone  circular que fica do lado dos produtos e suas configurações
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data["icon"]as String),
      ),
      title: Text(snapshot.data["title"]as String),
      //cria a setinha do final do botão
      trailing: Icon(Icons.keyboard_arrow_right),
      /*onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>CategoryScreen(snapshot))
        );
      },*/
    );
  }
}