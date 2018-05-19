import 'package:flutter/material.dart';
import 'package:flutkart/utils/flutkart.dart';
import 'package:flutkart/Fragments/First_Fragment.dart';


class page extends StatelessWidget {
  String title;
  page(this.title);
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child:  new Text(title),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  TabController tabController;
//here in the initstate we assign the tabcontroller and give it a length and vsyc for animation.
  @override
  void initState(){
    super.initState();
    tabController = new TabController(length: 3,vsync: this);
  }
//dispose method for good practice.
  @override
  void dispose(){
    super.dispose();
    tabController.dispose();
  }
//our build widget of state class.
  @override
  Widget build(BuildContext context) {


    return new Scaffold(appBar:  new AppBar(
        backgroundColor: Colors.redAccent,
        title: new Center(child: new Container(
          child: Text('Home'),

        )) ),
        drawer: new Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the Drawer if there isn't enough vertical
          // space to fit everything.
          child: new ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  accountName: new Text("Akhil Patil"),
                  accountEmail: new Text("akhil.patil7@gmail.com")),
              new ListTile(
                title: new Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  FirstFragment();
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                title: new Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
//here we define our TabBarView.
        body: new TabBarView(
          children: <Widget>[
            new page("hey bottomNavigation"),new page('the other one!'),new page('headset is on?')
          ],
          controller: tabController,
        ),
//now we can just create a bottomnavigationBar under our scaffold
        bottomNavigationBar:new Material(
          color: Colors.redAccent,
          child: new TabBar(
            controller: tabController,
            tabs: <Widget>[
              new Tab(
                icon: new Icon(Icons.home),
                text: "Home",
              ),
              new Tab(
                icon: new Icon(Icons.sentiment_satisfied),
                text: "Services",

              ),
              new Tab(
                icon: new Icon(Icons.people),
                text: "About Us",
              ),
            ],
          ),
        )
    );//scaffold
  }
}

