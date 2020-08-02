import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rwh_assistant/home_page.dart';
import 'package:rwh_assistant/login_page.dart';

class Condition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    doo(context);
    return MyHomePage();
  }

  doo(context) async {
    FirebaseUser uss = await FirebaseAuth.instance.currentUser();
    if (uss == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ));
    }
  }
}
