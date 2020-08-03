import 'package:flutter/material.dart';
import './home_page.dart';

class Maintenance extends StatefulWidget {
  @override
  _MaintenanceState createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
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
                    'Maintenance',
                    style: TextStyle(fontFamily: 'Oswald', fontSize: 23),
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
      body: SingleChildScrollView(
        child: Container(
          height: 1100,
          width: double.infinity,
          padding: EdgeInsets.only(left: 40, right: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/maintenance.jpeg',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
