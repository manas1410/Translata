import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meraki/Screens/chatsRoomScreen.dart';
import 'package:meraki/Screens/profile.dart';
import 'package:meraki/helper/constants.dart';

import '../services/auth.dart';

InputDecoration textFieldInputDecoration(String xtext){
  return InputDecoration(
    hintText: xtext,
    border: OutlineInputBorder(),
  );
}

TextStyle simpleTextFieldStyle(){
  return TextStyle(
    fontSize: 16,
  );
}

TextStyle welcomeback(){
  return TextStyle(
      fontSize: 30,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w500,
      foreground: Paint()..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color.fromRGBO(44, 137, 0, 1),
          Color.fromRGBO(11, 33, 1, 1),
          Color.fromRGBO(44, 137, 0, 1.0),

          //add more color here.
        ],
      ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))
  );
}
TextStyle mediumTextFieldStyle(){
  return TextStyle(
      fontSize: 17,
      fontFamily: 'Montserrat'
  );
}
/*
PreferredSizeWidget appBarMain2(BuildContext context){
  AuthMethods authMethods =new AuthMethods();
  return AppBar(
    backgroundColor:Color.fromRGBO(120, 76, 66, 1),
    toolbarHeight: 60,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed:()=>
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.pop(context);
          }),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(40),
      ),
    ),

  );
}*/

PreferredSizeWidget appBarMain1(BuildContext context){

  AuthMethods authMethods =new AuthMethods();
  return AppBar(
    backgroundColor:Color.fromRGBO(120, 76, 66, 1),
    toolbarHeight: 60,
    title:
    GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Profile()));
      },
      child:Row(
        children: [
          Image.asset("assets/images/profilepic.png",
            height: MediaQuery.of(context).size.height*0.05,
          ),

        ],

      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(40),
      ),
    ),

  );
}

class appBarMain2 extends StatefulWidget implements PreferredSizeWidget{

  appBarMain2_1 createState()=> appBarMain2_1();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class appBarMain2_1 extends State<appBarMain2>{

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor:Color.fromRGBO(120, 76, 66, 1),
        toolbarHeight: 60,
        title:
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Profile()));
          },
          child:Column(
            children: [
              Image.asset("assets/images/profilepic.png",
                height: MediaQuery.of(context).size.height*0.05,
              ),
              DropdownButton<String>(
                value: Constants.language,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    Constants.language = newValue!;
                  });
                },
                items: <String>['One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ],

          ),
        ));

  }
//Your code here
}