import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chapter1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
    );
  }
}