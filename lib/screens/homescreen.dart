import 'package:ecobox3/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body:Container(
        
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.black/*.withOpacity(.03)*/,
    elevation: 10,
    leading: Align(
    alignment: Alignment.topLeft,
    child:InkWell(
        child:Icon(Icons.call_received),
        onTap:(){}
      ),
    ),
  );
    //actions: <Widget>[IconButton(icon: SvgPicture.asset("assetName"),onPressed: null,)],)
}