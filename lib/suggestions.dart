import 'package:flutter/material.dart';
import './home_page.dart';

class Suggestions extends StatefulWidget {
  @override
  _SuggestionsState createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
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
                  padding: EdgeInsets.only(left: 40),
                  margin: EdgeInsets.only(top: 10),
                  //padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                  child: Text(
                    'Suggestions',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Some tips to get the most out of your RWH system",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 600,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/images/Suggestions.jpeg',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
