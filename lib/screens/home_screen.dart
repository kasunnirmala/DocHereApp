import 'package:dochere_client/screens/tabs/list_view_tab.dart';
import 'package:dochere_client/screens/tabs/map_view_tab.dart';
import 'package:dochere_client/util/bottomNavigator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  // SocketIO socket;

  @override
  void initState() {
    super.initState();
    // initSocket();
    tabController = TabController(vsync: this, length: 2);
    
  }

  // initSocket() async {
  //   socket = await SocketIOManager()
  //       .createInstance(SocketOptions('http://192.168.8.100:5000/'));
  //   socket.onConnect((data) {
  //     print("connected...");
  //   });

  //   socket.on("doc_loc_change", (data) {
  //     print("DOC CHANGED");
  //     getAllDoctors();
  //   });

  //   socket.connect();
  // }

  // getAllDoctors() async {
  //   var url = "http://192.168.8.100:5000/doc_loc";

  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //    print(response.body);
  //   } else {
  //     print("Request failed with status: ${response.statusCode}.");
  //   }
  // }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Talk To Clinitians"),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.search),
            onPressed: () {},
          ),
        ],
        elevation: 5,
        bottom: TabBar(
          tabs: <Widget>[
            new Tab(
              text: "MapView",
              icon: Icon(FontAwesomeIcons.mapMarked),
            ),
            new Tab(
              text: "ListView",
              icon: Icon(FontAwesomeIcons.list),
            )
          ],
          controller: tabController,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 16,
            child: TabBarView(
              children: <Widget>[
                MapViewTab(),
                ListViewTab(),
              ],
              controller: tabController,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              color: Color(0xff2A2E43),
              child: Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SelectionCard(
                      title: "Nearby",
                      icon: FontAwesomeIcons.searchLocation,
                      onPressed: () {},
                    ),
                    SelectionCard(
                      title: "Home Visit",
                      icon: FontAwesomeIcons.shoePrints,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}

class SelectionCard extends StatelessWidget {
  const SelectionCard(
      {@required this.icon, @required this.title, @required this.onPressed});
  final String title;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () {},
      child: Card(
        elevation: 6,
        child: Container(
          width: 70,
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 25,
                color: Colors.white,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              )
            ],
          ),
        ),
        color: Color(0xff353A50),
      ),
    );
  }
}
