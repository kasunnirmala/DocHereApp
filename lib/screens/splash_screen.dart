import 'package:dochere_client/util/app_data.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppData.primaryGradientColor,
              AppData.secondaryGradientColor
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              alignment: Alignment.center,
              image: AssetImage("images/logo.png"),
              width: 250,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Find Your Nearest Doctor",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 200,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.white,
              textColor: Colors.black,
              child: Text(
                "MAKE STEPS",
                style: TextStyle(fontSize: 10),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
