import 'package:flutter/material.dart';

import 'chapter1.dart';
import 'chapter2.dart';
import 'chapter3.dart';
import 'chapter4.dart';
import 'chapter5.dart';
import 'chapter6.dart';
import 'chapter7.dart';
import 'chapter8.dart';
import 'chapter9.dart';
import 'chapter10.dart';
import 'chapter11.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // 跟随系统自动开启深色模式
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        routes: {
          '/': (context) => MyHomePage(title: 'Home Page'),
          '/Chapter1': (context) => Chapter1(),
          '/Chapter2': (context) => Chapter2(),
          '/Chapter3': (context) => Chapter3(),
          '/Chapter4': (context) => Chapter4(),
          '/Chapter5': (context) => Chapter5(),
          '/Chapter6': (context) => Chapter6(),
          '/Chapter7': (context) => Chapter7(),
          '/Chapter8': (context) => Chapter8(),
          '/Chapter9': (context) => Chapter9(),
          '/Chapter10': (context) => Chapter10(),
          '/Chapter11': (context) => Chapter11(),
        },
        // 初始路由页面为MyHomePage页面
        initialRoute: '/');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final map = {
    1: ' 开启Flutter之旅',
    2: ' 基础知识',
    3: ' 常用组件',
    4: ' Material Design风格组件',
    5: ' Cupertino风格组件',
    6: ' 页面布局',
    7: ' 手势',
    8: ' 资源和图片',
    9: ' 路由导航及数据持久化',
    10: ' 组件装饰和视觉效果',
    11: ' 动画',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new ListView.separated(
        // 列表长度
        itemCount: map.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Chapter' + (index + 1).toString() + map[index + 1]),
            onTap: () {
              Navigator.pushNamed(context, '/Chapter' + (index + 1).toString());
            },
          );
        },
      ),
    );
  }
}
