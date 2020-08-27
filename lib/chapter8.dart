import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chapter8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('自定义字体'),
      ),
      body: new Center(
        child: new Text(
          '你好 flutter',
          style: new TextStyle(fontFamily: 'Corben',fontSize: 36.0),
        ),
      ),
    );
  }
}