import 'package:flutter/material.dart'; 
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rwh_assistant/Calculation.dart';
import './home_page.dart';

class StepperClass extends StatefulWidget {
  StepperClass({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StepperClassState createState() => new _StepperClassState();
}

class _StepperClassState extends State<StepperClass> {
  int _currentStep = 0;
  int intValue;

  addIntToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intValue', _currentStep);
    print(_currentStep);
  }

  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intValue = prefs.getInt('intValue');
    return intValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Text(
                      'START BUILDING',
                      style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
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
          ],
        ),
      ),
      body: Stepper(
        steps: _mySteps(),
        currentStep: this._currentStep,
        onStepTapped: (steps) {
          setState(() {
            this._currentStep = steps;
            print(_currentStep);
          });
        },
        onStepContinue: () {
          setState(
            () {
              if (this._currentStep < this._mySteps().length - 1) {
                this._currentStep = this._currentStep + 1;
              } else {
                //Logic to check if everything is completed
                _showToast();
              }
            },
          );
        },
        onStepCancel: () {
          setState(() {
            if (this._currentStep > 0) {
              this._currentStep = this._currentStep - 1;
            } else {
              this._currentStep = 0;
            }
          });
        },
      ),
    );
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text(
          'Step 1: Building a storage tank',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Column(
          children: <Widget>[
            Text(
              'A storage tank is built to collect the harvested rainwater. The capacity of storage tank is determined by size of the roof, average rainfall (in mm) and number of people using the collected water. Decide the type of your tank (RCC, Cement, Plastic).\n',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Container(
              width: 250,
              height: 230,
              child: Image.asset(
                'assets/images/Step1.png',
              ),
            ),
          ],
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text(
          'Step 2: Connecting pipes',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Column(
          children: <Widget>[
            Text(
              'Number of outlets on the roof is provided depending upon the size of the roof for the flow of rainwater, '
              'where each outlet is covered by a mesh to stop the flow of dirt along with the rainwater.\n',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Container(
              width: 250,
              height: 230,
              child: Image.asset(
                'assets/images/Step2.png',
              ),
            ),
          ],
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text(
          'Step 3: Connecting a filter',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Column(
          children: <Widget>[
            Text(
              'The outlet pipes are connected to a filter, '
              'the rainwater flows through it to remove the remaining dirt and the filtered water is stored in a tank.\n',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Container(
              width: 250,
              height: 230,
              child: Image.asset(
                'assets/images/Step3.png',
              ),
            ),
          ],
        ),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: Text(
          'Step 4: Recharging groundwater \n(optional) ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Column(
          children: <Widget>[
            Text(
              'A percolation pit is built to recharge the underground water for maximum usage of rainwater.\n',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Container(
                width: 250,
                height: 230,
                child: Image.asset(
                  'assets/images/Step4.png',
                )),
          ],
        ),
        isActive: _currentStep >= 3,
      ),
    ];
    return _steps;
  }

  FlutterToast flutterToast;

  @override
  void initState() {
    super.initState();
    flutterToast = FlutterToast(context);
  }

  _showToast() {
    Widget toast = Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black87,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
            width: 30.0,
          ),
          Text(
            "Congratulations! You've \nsuccessfully built a RWH system.",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    flutterToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 5),
    );
  }
}
