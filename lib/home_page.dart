import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Home_Page extends StatefulWidget {
  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 100,
                    width: 80,
                    //color: Colors.red,
                    child: Image.asset("assets/image1.png"),
                  )),
              Expanded(
                child: Container(
                  height: 80,
                  child: WavyAnimatedTextKit(
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                    text: [
                      "Familly Chat",
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Enter_Data(
            tittle: 'Log in',
            onpress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            color: Color(0xff3A6EFF),
          ),
          SizedBox(
            height: 30.0,
          ),
          Enter_Data(
            tittle: 'Register',
            onpress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            color: Color(0xff24439A),
          ),
        ],
      ),
    );
  }
}

class Enter_Data extends StatelessWidget {
  Enter_Data({
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
