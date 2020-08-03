import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rwh_assistant/database.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import './login_page.dart';
import 'http_exception.dart';
import './loading.dart';
import './database1.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white70,
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.bold,
  fontSize: 17,
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 20,
  fontFamily: 'OpenSans',
);

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  bool loading = false;
  String username, confirmpass;
  String password, email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return loading
        ? Loading()
        : Scaffold(
            body: Stack(
              children: <Widget>[
                Container(
                  color: Colors.blue[900],
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 80,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/logo1.jpeg',
                              fit: BoxFit.contain,
                              height: height * 0.1,
                            ),
                            Text(
                              'AQUASTORE',
                              style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.white,
                                fontFamily: 'Oswald',
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 380,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      validator: (input) {
                                        if (input.isEmpty) {
                                          return 'Username can not be blank';
                                        }
                                      },
                                      onSaved: (input) => username = input,
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(top: 13),
                                        prefixIcon: Icon(Icons.account_circle,
                                            color: Colors.white),
                                        hintText: 'Enter your name',
                                        hintStyle: kHintTextStyle,
                                      ),
                                    ),
                                    Text(""),
                                    TextFormField(
                                      cursorColor: Colors.white,
                                      style: TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: validateEmail,
                                      onSaved: (input) => email = input,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(top: 13),
                                        prefixIcon: Icon(Icons.email,
                                            color: Colors.white),
                                        hintText: 'Enter your Email',
                                        hintStyle: kHintTextStyle,
                                      ),
                                    ),
                                    Text(""),
                                    TextFormField(
                                      cursorColor: Colors.white,
                                      style: TextStyle(color: Colors.white),
                                      obscureText: true,
                                      validator: (input) {
                                        if (input.length < 6) {
                                          return 'Please type an password with atleast 6 characters';
                                        }
                                      },
                                      onSaved: (input) => password = input,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(top: 13),
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.white),
                                        hintText: 'Enter Password',
                                        hintStyle: kHintTextStyle,
                                      ),
                                    ),
                                    Text(""),
                                    TextFormField(
                                      cursorColor: Colors.white,
                                      style: TextStyle(color: Colors.white),
                                      obscureText: true,
                                      onSaved: (input) {
                                        confirmpass = input;
                                      },
                                      validator: (input) {
                                        _formKey.currentState.save();
                                        if (confirmpass != password) {
                                          return 'Password do not match';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(top: 13),
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.white),
                                        hintText: 'Confirm Password',
                                        hintStyle: kHintTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: double.infinity,
                              margin: EdgeInsets.all(20),
                              child: RaisedButton(
                                elevation: 10,
                                padding: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.blue[900],
                                      letterSpacing: 1.5,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans'),
                                ),
                                onPressed: signUp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  FlutterToast flutterToast;

  @override
  void initState() {
    super.initState();
    flutterToast = FlutterToast(context);
  }

  _showToast() {
    Widget toast = Container(
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
            "Verification email has been sent.\nPlease check your email.",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    flutterToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 4),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();

      setState(() {
        loading = true;
      });

      FirebaseUser user =
          (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
              .user;

      await DatabaseService(uid: user.uid)
          .updateUserData('0', '0', 'null', 'null');
      _showToast();

      //user.sendEmailVerification(); // display for user that we sent an email
      try {
        await user.sendEmailVerification();

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));

        return user.uid;
      } on HttpException catch (error) {
        print(error.toString());
        var errorMessage = 'Authentication failed';
        if (error.toString().contains('EMAIL_EXISTS')) {
          errorMessage = 'This email address is already in use.';
        }
        _showErrorDialog(errorMessage);
      } catch (e) {
        print(e.toString());
        const errorMessage =
            'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
      }
    }
  }
}
