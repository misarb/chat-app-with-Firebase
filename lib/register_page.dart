import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Image.asset("assets/image.png"),
          ),
          Center(
            child: Container(
              //padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 50, right: 50),
              child: TyperAnimatedTextKit(
                  onTap: () {
                    print("Tap Event");
                  },
                  text: [
                    "Feel free to chat",
                    "with your familly",
                    "in secret",
                    "Enjoy with us",
                  ],
                  textStyle: TextStyle(
                    fontSize: 25.0,
                    fontFamily: "Bobbers",
                    color: Color(0xff9A9A9A),
                  ),
                  textAlign: TextAlign.start,
                  alignment:
                      AlignmentDirectional.topStart // or Alignment.topLeft
                  ),
            ),
          ),
          SizedBox(
            height: 10,
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
          //password setting
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
                labelText: 'Entre your password',
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
            child: EnterData(
              tittle: 'Register',
              onpress: () async {
                // print(email);
                // print(password);
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (newUser != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScreenChat()),
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
              color: Color(0xff24439A),
            ),
          )
        ],
      ),
    );
  }
}

class EnterData extends StatelessWidget {
  EnterData({
    @required this.tittle,
    this.onpress,
    this.color,
  });
  String tittle;
  Function onpress;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50,
      width: 310.0,
      child: FloatingActionButton.extended(
        heroTag: null,
        onPressed: onpress,
        label: Text(
          tittle,
          style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.normal),
        ),
        backgroundColor: color,
      ),
    );
  }
}
