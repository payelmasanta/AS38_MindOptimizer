import 'package:flutter/material.dart';
import 'home_page.dart';

class Calculations extends StatefulWidget {
  @override
  CalculationsState createState() => CalculationsState();
}

class CalculationsState extends State<Calculations> {
  double roofsize, demand;
  int people;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Stack(
          children: <Widget>[
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 40.0, right: 8.0),
                    child: Text(
                      'Calculate Rainfall',
                      style: TextStyle(fontFamily: 'Open Sans', fontSize: 23),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  //margin: EdgeInsets.only(left: 83, right: 0),
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
          margin: EdgeInsets.only(left: 10, right: 00),
          padding: EdgeInsets.only(
            top: 30,
            left: 5,
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(""),
                  Text(''),
                  Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Enter the roof size (in m\u00B2):     ',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (input) {
                              if (input.isEmpty) {
                                return ('Roofsize can not be blank');
                              }
                            },
                            onSaved: (input) {
                              roofsize = double.parse(input);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Text(''),
                          Text(''),
                          Text(
                            'Number of People using the water:',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (input) {
                              if (input.isEmpty) {
                                return ('This field can not be blank');
                              }
                            },
                            onSaved: (input) {
                              people = int.parse(input);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Text(''),
                          Text(''),
                          Text(
                            'Water demand per person:',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (input) {
                              if (input.isEmpty) {
                                return ('This field  can not be blank');
                              }
                            },
                            onSaved: (input) {
                              demand = double.parse(input);
                              //print(demand);
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                border: OutlineInputBorder(),
                                hintText: "(Eg: 20 liters per day per person)"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // catchment start
                  Text(
                      "The minimum water demand according to the World Health Organization (WHO) is "
                      "20 litres per day. In semi-arid areas people often use less than 20 liters per person per day."),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
