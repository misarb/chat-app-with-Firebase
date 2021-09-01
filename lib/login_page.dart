import 'package:Familly_Chat/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            //padding: EdgeInsets.all(10),
            height: 350.0,
            child: Image.asset("assets/image1.png"),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              obscureText: false,
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                labelText: 'Enter your email',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff3A6EFF),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          //password loging
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                labelText: 'Enter your password',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff3A6EFF),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50, top: 20),
            child: FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                try {
                  final user = _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScreenChat()),
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
              label: Text(
                "Log in",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.normal),
              ),
              backgroundColor: Color(0xff3A6EFF),
            ),
          ),
        ],
      ),
    );
  }
}
