import 'package:dochere_client/screens/home_screen.dart';
import 'package:dochere_client/util/app_data.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ClipPath(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Color(0xffC8FFE7),
              ),
              clipper: BackgroundClipper(),
            ),
          ),
          Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage("images/logo2.png"),
                    width: 250,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    height: 60,
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          hintText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    height: 80,
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          hintText: "Password"),
                      obscureText: true,
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          AppData.primaryGradientColor,
                          AppData.secondaryGradientColor
                        ],
                      ),
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      color: Colors.transparent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 3,
                            color: Colors.grey[300],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "OR",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 3,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.grey[300])),
                    child: Text(
                      "SIGNUP",
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff00C4DD),
                          fontWeight: FontWeight.w900),
                    ),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 200);
    path.lineTo(0, size.height);
    path.lineTo(100, size.height);
    path.lineTo(size.width, 400);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height - 50);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
