import 'package:rwh_assistant/home_page.dart';
import 'package:rwh_assistant/start_building.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

class ResultPage extends StatefulWidget {
  final String dryres, wetres;
  final double dem;
  final int pep;
  final String mondry, monwet, selectedCatchment;
  final double raindry, rainwet, roofsize, catchValue;

  const ResultPage(
    this.dryres,
    this.wetres,
    this.dem,
    this.pep,
    this.mondry,
    this.monwet,
    this.selectedCatchment,
    this.raindry,
    this.rainwet,
    this.roofsize,
    this.catchValue,
  );
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<charts.Series> seriesList;
  List<charts.Series<Chartseries, String>> create() {
    final deman = widget.dem;
    final pepp = widget.pep;
    final demm = deman * pepp * 30;
    final chartrainwet = [
      Chartseries(
        demand: demm,
        resultdry: double.parse(widget.dryres),
        resultwet: double.parse(widget.wetres),
        litres: "Collected/Demand",
      ),
    ];

    final chartdem = [
      Chartseries(
        demand: demm,
        resultdry: double.parse(widget.dryres),
        resultwet: double.parse(widget.wetres),
        litres: "Collected/Demand",
      ),
    ];
    return [
      charts.Series<Chartseries, String>(
        id: 'RsultWet',
        domainFn: (Chartseries chart, _) => chart.litres,
        measureFn: (Chartseries chart, _) => chart.resultwet,
        data: chartrainwet,
      ),
      charts.Series<Chartseries, String>(
          id: 'RsultWet',
          domainFn: (Chartseries chart, _) => chart.litres,
          measureFn: (Chartseries chart, _) => chart.demand,
          data: chartdem,
          fillColorFn: (Chartseries chart, _) {
            return charts.MaterialPalette.green.shadeDefault;
          })
    ];
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
    );
  }

  List<charts.Series> chList;
  static List<charts.Series<CatchChart, String>> createCa() {
    final catchdata = [
      CatchChart(type: 'Brick', value: 55),
      CatchChart(type: 'Concrete', value: 70),
      CatchChart(type: 'Metal sheets', value: 80),
      CatchChart(type: 'Tiles', value: 85),
    ];
    return [
      charts.Series<CatchChart, String>(
        id: 'CatchValue',
        domainFn: (CatchChart catchchart, _) => catchchart.type,
        measureFn: (CatchChart catchchart, _) => catchchart.value,
        data: catchdata,
      )
    ];
  }

  caChart() {
    return charts.BarChart(
      chList,
      animate: true,
      vertical: true,
    );
  }

  @override
  void initState() {
    super.initState();
    seriesList = create();
    chList = createCa();
  }

  //final double wrain = City().wet_rain;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String vol1 = widget.dryres;
    String vol2 = widget.wetres;
    double dema = widget.dem;
    int peop = widget.pep;
    double totdem = dema * peop;
    double totald = totdem * 30;
    String scatch = widget.selectedCatchment;
    double cval = widget.catchValue;
    double cvalper = cval * 100;
    double roof = widget.roofsize;
    double rdry = widget.raindry;
    double rwet = widget.rainwet;
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
                      'Summary',
                      style: TextStyle(fontFamily: 'Oswald', fontSize: 23),
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
          padding: EdgeInsets.only(left: 10, right: 8),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(6),
                width: double.infinity,
                height: 130,
                child: Card(
                  color: Colors.blue[200],
                  elevation: 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(""),
                      Text(
                        "Rainfall",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(""),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "The average rainfall is taken from \"timeanddate.com\" \ndepending on your current location.",
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text(''),
              Container(
                padding: EdgeInsets.only(left: 15, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Description:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      "The average rainfall at this location varies between $rdry mm in the driest month and $rwet mm in the wettest month.",
                      style: TextStyle(fontFamily: 'Open Sans'),
                    ),
                  ],
                ),
              ),
              Text(''),
              Text(''),
              Container(
                padding: EdgeInsets.all(6),
                width: double.infinity,
                height: 130,
                child: Card(
                  color: Colors.blue[100],
                  elevation: 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(""),
                      Text(
                        "Water availability",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(""),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "The water availability is calculated depending on the \naverage rainfall, run-off coefficient and the roof area.",
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text(''),
              Container(
                padding: EdgeInsets.only(left: 15, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Description:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: 'Open Sans'),
                    ),
                    Text(
                      "A $scatch roof has a runoff coefficient of $cval, which means that $cvalper % of the rain can be harvested. Based on this runoff coeeficient and a "
                      "roof area of $roof square metres a volume of $vol1 of water can be collected in the driest month and $vol2 in the wettest month.",
                      style: TextStyle(fontFamily: 'Open Sans'),
                    ),
                  ],
                ),
              ),
              Text(''),
              Container(
                height: 300,
                width: width * 1,
                padding: EdgeInsets.all(20),
                child: caChart(),
              ),
              Text(''),
              Text(''),
              Container(
                padding: EdgeInsets.all(6),
                width: double.infinity,
                height: 140,
                child: Card(
                  color: Colors.blue[200],
                  elevation: 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(""),
                      Text(
                        "Water Demand",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(""),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "The water demand depends on the number of \npeople using the water and average amount of \nwater used by each person.",
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text(''),
              Container(
                padding: EdgeInsets.only(left: 15, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Description:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: 'Open Sans'),
                    ),
                    Text(
                      "Since there are $peop people and the water demand per person is $dema litres per day, the total water demand is $totdem litres per day, which equals to about $totald litres per month.\n\n The below graph shows the collected water vs total demand.",
                      style: TextStyle(fontFamily: 'Open Sans'),
                    ),
                  ],
                ),
              ),
              Text(''),
              Container(
                height: 300,
                width: width * 0.8,
                padding: EdgeInsets.all(20),
                child: barChart(),
              ),
              Text(''),
              Text(''),
              Container(
                padding: EdgeInsets.all(6),
                width: double.infinity,
                height: 140,
                child: Card(
                  color: Colors.blue[100],
                  elevation: 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(""),
                      Text(
                        "Required Storage",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(""),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Volume of the required storage element will depend \non the water collected and the duration for which \nthe water is needed to be stored.",
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text(''),
              Container(
                padding: EdgeInsets.only(left: 15, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Description:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      "Since the amount of water that can be collected from this roof is enough to fulfil part of the demand, no large storage reservior is required. A small storage tank to bridge a number of days without rain should be enough to provide an adequate water supply throughout the year. Existing storage element(if any) can be used to store the water after filtration. ",
                      style: TextStyle(fontFamily: 'Open Sans'),
                    ),
                  ],
                ),
              ),
              Text(''),
              Text(''),
              Text(''),
              Text(''),
              Text(''),
              Text(''),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.grey[350],
                    child: Text(
                      'Go to Homepage',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.grey[350],
                    child: Text(
                      'Start Building your\nRWH system',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StepperClass(),
                      ),
                    ),
                  ),
                ],
              ),
              Text(""),
            ],
          ),
        ),
      ),
    );
  }
}

class Chartseries {
  final String litres;
  final double demand, resultdry, resultwet;
  final charts.Color barColor;

  Chartseries({
    @required this.demand,
    @required this.resultdry,
    @required this.resultwet,
    @required this.litres,
    this.barColor,
  });
}

class CatchChart {
  final String type;
  final double value;
  final charts.Color barColor;

  CatchChart({
    @required this.type,
    @required this.value,
    this.barColor,
  });
}
