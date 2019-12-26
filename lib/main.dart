import 'package:dochere_client/screens/login.dart';
import 'package:dochere_client/util/socket_singleton.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with ChangeNotifier {
  var s1;
  @override
  void initState() {
    super.initState();
    s1 = SocketSingleton();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DocHere',
      home: SafeArea(
        child: Login(),
      ),
    );
  }
}
