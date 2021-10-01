import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LaunchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: <Color>[
              Color.fromRGBO(134, 217, 197, 1.0),
              Color.fromRGBO(244, 244, 244, 1.0),
            ], 
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Container(
            child: Image(
              image: AssetImage("assets/logo/logo.png"),
              width: 130,
              height: 130,
            ),
          ),
        ),
      ),
    );
  }
}
