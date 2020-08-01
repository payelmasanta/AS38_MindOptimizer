import 'package:flutter/material.dart';
import 'package:rwh_assistant/home_page.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(left: 80.0, right: 8.0),
                child: Text(
                  'About Us',
                  style: TextStyle(fontFamily: 'Open Sans', fontSize: 23),
                )),
            Container(
              margin: EdgeInsets.only(left: 50, right: 0),
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
      ),
      body: Container(),
    );
  }
}
