import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasalny/modules/driver_signin/driver_signin.dart';
import 'package:wasalny/modules/user_home_screen/user_home_screen.dart';
import 'package:wasalny/shared/components/components.dart';
import 'package:wasalny/shared/constatnts/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: SizedBox(),
          ),
          Center(
            child: Hero(
              tag: 1,
              child: Image(
                  height: 260,
                  width: 260,
                  image: AssetImage(
                    'lib/images/logo.png',
                  )),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          defaultButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserHomeScreen()));
              },
              text: 'continue as a passenger',
              width: 250,
              color: kMainColor),
          SizedBox(
            height: 15,
          ),
          defaultButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DriverSignIn()));
              },
              text: 'continue as a driver',
              width: 250,
              color: kSecColor),
          Expanded(
            flex: 6,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
