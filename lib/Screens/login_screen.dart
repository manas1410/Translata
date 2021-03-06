import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meraki/Screens/profile.dart';
import 'package:meraki/helper/helperfunction.dart';
import 'package:meraki/services/auth.dart';
import 'package:meraki/services/database.dart';
import 'package:meraki/widget/widgets.dart';

import 'chatsRoomScreen.dart';


String user = "";
class SignIn extends StatefulWidget {
  //const SignIn({Key? key}) : super(key: key);
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTextEditingController =
  new TextEditingController();
  TextEditingController passwordTextEditingController =
  new TextEditingController();

  bool isLoading = false;
  QuerySnapshot? snapshotUserInfo;
  signIn() {

    if (formKey.currentState!.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text);

      setState(() {
        isLoading = true;
        user = emailTextEditingController.text;
      });
      databaseMethods
          .getUserByUseremail(emailTextEditingController.text)
          .then((val) {
        setState(() {
          snapshotUserInfo = val;
          HelperFunctions.saveUserNameSharedPreference(
              snapshotUserInfo!.docs[0]['name']);
          //print("${snapshotUserInfo!.docs[0]['name']} hello hellooo");
        });
      });
      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
          passwordTextEditingController.text)
          .then((val) {
        if (val != null) {
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()
          )
          );
        }
      });
    }
  }
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 237, 223, 1),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.amberAccent,
          //padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: Stack(
                        children:<Widget>[
                          Positioned(
                              child:
                              Image.asset("assets/images/cyber1.png",
                                  height: MediaQuery.of(context).size.height*0.4,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill
                              )),
                          Positioned(
                              child:
                              Image.asset("assets/images/cyber1.png",
                                  height: MediaQuery.of(context).size.height*0.36,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill
                              )),
                          Positioned(
                              top: MediaQuery.of(context).size.height*0.01,
                              right: MediaQuery.of(context).size.width*0.04,
                              child:
                              Image.asset("assets/images/cyber.png", height: 200,)),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Container(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            "Welcome Back!",
                            style: welcomeback(),

                          ),
                        )),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        Wrap(
                          children: [
                            Container(
                              child: Image.asset("assets/images/user.png",
                                height: MediaQuery.of(context).size.height*0.06,
                              ),
                            ),
                            Container(
                              width:  MediaQuery.of(context).size.width*0.83,
                              height: MediaQuery.of(context).size.height*0.09,
                              child: TextFormField(
                              validator: (val) {
                                return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                    ? null
                                    : "Please enter valid email address";
                              },
                              controller: emailTextEditingController,
                              style: simpleTextFieldStyle(),
                              decoration: InputDecoration(
                                  hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Color.fromRGBO(175, 175, 175, 1))

                              ),
                          ),
                            ),]
                        ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.02,
                    ),
                Wrap(
                  children: [
                    Container(
                      child: Image.asset("assets/images/pass.png",
                        height:  MediaQuery.of(context).size.height*0.06,
                      ),
                    ),
                    Container(
                      width:  MediaQuery.of(context).size.width*0.83,
                      height: MediaQuery.of(context).size.height*0.09,
                      child: TextFormField(
                        obscureText: _isObscure,
                        validator: (val) {
                          return (val!.length > 6)
                              ? null
                              : "Please provide password atleast 7 character";
                        },
                        controller: passwordTextEditingController,
                        style: simpleTextFieldStyle(),
                        decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: IconButton(
                                icon: Icon(
                                    _isObscure ? Icons.visibility : Icons.visibility_off,
                                color: Color.fromRGBO(245, 237, 223, 1),),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Color.fromRGBO(175, 175, 175, 1))

                        ),
                      ),
                    ),]
        )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        fontSize: 14,
                          decoration: TextDecoration.underline
                      ),

                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  signIn();
                },
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width*0.40,
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(38, 108, 5, 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Montserrat',
                        fontSize: 23,
                      ),
                    ),
                  ),


              ),
              SizedBox(
                height: 8,
              ),
              /*Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width*0.40,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color:Color.fromRGBO(38, 108, 5, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Image.asset("assets/images/google.png",
                      height: 30,
                    ),
                    Text("  Sign In with Google",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),*/
              SizedBox(
                height: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account? ",
                    style: mediumTextFieldStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Register Now ",
                        style: TextStyle(
                          color: Color.fromRGBO(120, 76, 66, 1),
                          fontFamily: 'Montserrat',
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 110,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
