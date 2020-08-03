import 'dart:io';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:app_settings/app_settings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './home_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite/tflite.dart';
import 'dart:math';

class ImagePage extends StatefulWidget {
  //This function extracts the exif of the image and prints its data

  @override
  ImagePageState createState() => ImagePageState();
}

class ImagePageState extends State<ImagePage> {
  String locationlat = "", locationlong = "", place;
  double locationla, locationlo;
  String lati, longi;
  String placeName = '';

  File imageYRI;
  final picker = ImagePicker();

  String result;
  String path;

  Future getCurrentLocation() async {
    bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();
    if (isLocationEnabled) {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      debugPrint('location: ${position.latitude}');
      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("${first.featureName} : ${first.addressLine}");
      // setState(() {
      locationlat = "${position.latitude}";
      locationlong = "${position.longitude}";
      placeName = " ${first.subAdminArea}";
      print(placeName);
      // });

      return placeName;
    } else {
      showDialog(
          context: context, builder: (BuildContext context) => errorDialog);
      // AppSettings.openLocationSettings();
    }
  }

  printExifOf(String path) async {
    String latii, longii;
    Map<String, IfdTag> data =
        await readExifFromBytes(await new File(path).readAsBytes());

    if (data == null || data.isEmpty) {
      print("No EXIF information found\n");
      return;
    }

    if (data.containsKey('JPEGThumbnail')) {
      print('File has JPEG thumbnail');
      data.remove('JPEGThumbnail');
    }
    if (data.containsKey('TIFFThumbnail')) {
      print('File has TIFF thumbnail');
      data.remove('TIFFThumbnail');
    }

    data.forEach(
      (key, value) {
        if (key == "GPS GPSLatitude") {
          print({"$key": "$value"});
          var lat = value;

          final latitude = lat.values
              .map<double>((item) =>
                  (item.numerator.toDouble() / item.denominator.toDouble()))
              .toList();

          //print(latitude);

          var laty =
              latitude[0] + ((latitude[1]) / 60) + ((latitude[2]) / 3600);
          var lati = laty.toString();
          latii = lati.substring(0, 8);

          //print(lati);

          //Func(locationlat, latii);
        }

        if (key == "GPS GPSLongitude") {
          print({"$key": "$value"});
          var long = value;
          final longitude = long.values
              .map<double>((item) =>
                  (item.numerator.toDouble() / item.denominator.toDouble()))
              .toList();

          var longy =
              longitude[0] + ((longitude[1]) / 60) + ((longitude[2]) / 3600);
          var longi = longy.toString();
          longii = longi.substring(0, 8);
        }
        Func(locationlat, latii, locationlong, longii);
      },
    );
  }

  Future<void> _takeImage() async {
    final _imageTaken = await picker.getImage(source: ImageSource.gallery);
    if (_imageTaken == null) return;
    setState(() {
      imageYRI = File(_imageTaken.path);
      path = _imageTaken.path;
    });
    printExifOf(_imageTaken.path);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'VERIFY WORK',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
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
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(""),
                FlatButton(
                    color: Colors.blue[300],
                    child: Text('Get Location'),
                    onPressed: () {
                      getCurrentLocation();
                    }),
                Text(placeName),
                Text(locationlat),
                Text(locationlong),
                FlatButton(
                  color: Colors.blue[300],
                  onPressed: () {
                    _takeImage();
                  },
                  child: Text('Take image from storage'),
                ),
                Text(""),
                imageYRI == null
                    ? Text('No image selected')
                    : Image.file(imageYRI,
                        width: 300, height: 200, fit: BoxFit.cover),
                //Func(locationlat, printExifOf(path).latii, locationlong,
                //printExifOf(path).longii)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Func(String locationlat, latii, locationlong, longii) {
    print(locationlat);
    print(locationlong);
    String locala = locationlat.substring(0, 8);
    String local = locationlong.toString();
    String localo = local.substring(0, 8);
    print(locala);
    print(latii);
    print(localo);
    print(longii);

    try {
      if (locala == latii && localo == longii) {
        print('matched');
        _showToast();
      } else {
        print('not matched');
        _showToast1();
      }
    } catch (e) {
      print('exception');
    }
  }

  FlutterToast flutterToast;
  FlutterToast flutterToast1;

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
            "Location Matched",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    flutterToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 1),
    );
  }

  _showToast1() {
    Widget toast1 = Container(
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
            "Location didn't match",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    flutterToast1.showToast(
      child: toast1,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  void initState() {
    super.initState();
    flutterToast = FlutterToast(context);
  }

  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)), //this right here
    child: Container(
      height: 200.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(""),
          Text(""),
          Container(
            padding: EdgeInsets.only(left: 20, right: 15),
            child: Text(
              'To continue, turn on device location.',
              style: TextStyle(fontSize: 22, color: Colors.grey),
            ),
          ),
          Text(""),
          Container(
            padding: EdgeInsets.only(left: 40, top: 40),
            margin: EdgeInsets.only(bottom: 10, right: 1),
            child: FlatButton(
              onPressed: () {
                AppSettings.openLocationSettings();
              },
              child: Text(
                'Go to Location settings >>',
                style: TextStyle(color: Colors.blue, fontSize: 17.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
