import 'package:flutter/material.dart';
import './Calculation.dart';
import './about_screen.dart';
import './connect_vendors.dart';
import './start_building.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class Constants {
  static const String AboutUs = 'About Us';
  static const String SignOut = 'Sign out';

  static const List<String> choices = <String>[AboutUs, SignOut];
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Colors.blue[900],
        title: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  //margin: EdgeInsets.only(left: 0, right: 50),
                  child: Image.asset(
                    'assets/images/logo1.jpeg',
                    fit: BoxFit.contain,
                    height: 50,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 10),
                    //padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'AQUASTORE',
                      style: TextStyle(
                          fontFamily: 'Oswald',
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  //padding: const EdgeInsets.only(left: 69.0),
                  margin: EdgeInsets.only(right: 0),
                  child: PopupMenuButton<String>(
                    onSelected: choiceAction,
                    itemBuilder: (BuildContext context) {
                      return Constants.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        // height: double.infinity,
        // width: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 70,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: RaisedButton(
                  child: Text(
                    'Calculate Rainfall',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  color: Colors.blue[500],
                  elevation: 5,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Calculations(),
                        ));
                  },
                ),
              ),
              //const SizedBox(width:100,),
              Container(
                height: 70,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: RaisedButton(
                  child: Text(
                    'Start Building your RWH system',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StepperClass(),
                        ));
                  },
                  color: Colors.blue[300],
                ),
              ),
              //const SizedBox( width:100,),
              Container(
                height: 70,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: RaisedButton(
                  child: Text(
                    'Connect with vendors',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConnectVendors(),
                        ));
                  },
                  color: Colors.blue[100],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                margin: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.AboutUs) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AboutScreen(),
          ));
    } else if (choice == Constants.SignOut) {
      //signnOut();
    }
  }
}
