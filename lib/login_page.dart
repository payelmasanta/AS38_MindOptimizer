import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './forgot_pass.dart';
//import 'package:firebase_core/firebase_core.dart';
import './signup_page.dart';
import 'dart:async';
import './home_page.dart';
import './loading.dart';

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

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  String email, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
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
                      vertical: 100,
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
                              height: 300,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(""),
                                    Text(""),
                                    Text(""),
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      validator: validateEmail,
                                      onSaved: (input) => email = input,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(top: 12),
                                        prefixIcon: Icon(Icons.email,
                                            color: Colors.white),
                                        hintText: 'Enter your Email',
                                        hintStyle: kHintTextStyle,
                                      ),
                                    ),
                                    Text(""),
                                    TextFormField(
                                      obscureText: true,
                                      onSaved: (input) => password = input,
                                      validator: (input) {
                                        if (input.length < 6) {
                                          return 'Please enter a valid password';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(top: 12),
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.white),
                                        hintText: 'Enter Password',
                                        hintStyle: kHintTextStyle,
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ForgotPass(),
                                          )),
                                      padding: EdgeInsets.only(right: 0),
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
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
                                  'Sign In',
                                  style: TextStyle(
                                      color: Color(0xFF527DAA),
                                      letterSpacing: 1.5,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans'),
                                ),
                                onPressed: signIn,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 15),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpPage(),
                                    )),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Don\'t have an Account?   ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Sign Up ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
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

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      setState(() {
        loading = true;
      });
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password))
            .user;

        if (user.isEmailVerified) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ));

          return user.uid;
        } else {
          setState(() {
            ErrorHint('Could not sign in with these credentials');
            loading = false;
          });
        }
      } catch (e) {
        print(e.message);
      }
    }
  }
}
