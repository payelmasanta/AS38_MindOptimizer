import 'package:flutter/material.dart';
import 'package:rwh_assistant/home_page.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text(
                  'ABOUT US',
                  style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
              ),
              Container(
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
      ),
      body: Column(
        children: <Widget>[
          Text(""),
          Text(""),
          Container(
            height: 600,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/images/aboutus.jpg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
