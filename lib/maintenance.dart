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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'MAINTENANCE',
                  style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                FlatButton(
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
