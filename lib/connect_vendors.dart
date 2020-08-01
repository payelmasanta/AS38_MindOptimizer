import 'package:flutter/material.dart';
import 'home_page.dart';

class ConnectVendors extends StatefulWidget {
  @override
  ConnectVendorsState createState() => ConnectVendorsState();
}

class ConnectVendorsState extends State<ConnectVendors> {
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
                  margin: EdgeInsets.only(top: 10),
                  //padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                  child: Text(
                    'Connect with vendors',
                    style: TextStyle(fontFamily: 'Open Sans', fontSize: 23),
                  ),
                ),
              ],
            ), 
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  //margin: EdgeInsets.only(left: 25, right: 0),
                  child: FlatButton(
                    color: Colors.blue[900],
                    child: Image.asset(
                      'assets/images/logo1.jpeg',
                      height: 50,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
