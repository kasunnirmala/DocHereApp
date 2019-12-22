import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigator extends StatelessWidget {
  final int indx;
  BottomNavigator({this.indx = 1});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 50,
      backgroundColor: Color(0xff2A2E43),
      index: indx,
      items: <Widget>[
        Icon(FontAwesomeIcons.user,size: 25,),
        Icon(FontAwesomeIcons.home, size: 25),
        Icon(FontAwesomeIcons.clipboard, size: 25),
      ],
      onTap: (index) {
        //Handle button tap
      },
    );
  }
}
