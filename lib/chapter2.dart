import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Chapter2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      ThemeDemo(),
      PackageDemo(),
      StateDemo(),
      ProviderDemo(),
      HttpDemo(),
      HttpClientDemo(),
      DioDemo(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('基础知识'),
      ),
      body: ListView(
        children: list.map((widget) {
          return ListTile(
            title: Text(widget.toString()),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => widget),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class ThemeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appName = '自定义主题';

    return MaterialApp(
      title: appName,
      //主题配置
      theme: ThemeData(
        //应用程序整体主题的亮度
        brightness: Brightness.light,
        //App主要部分的背景色
        primaryColor: Colors.lightGreen[600],
        //前景色（文本、按钮等）
        accentColor: Colors.orange[600],
      ),
      home: MyHomePage(
        title: appName,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  //标题
  final String title;

  //接收title值 key为widget的唯一标识
  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          //获取主题的accentColor
          color: Theme.of(context).accentColor,
          child: Text(
            '带有背景颜色的文本组件',
            //获取主题的文本样式
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
      floatingActionButton: Theme(
        //使用copyWith的方式获取accentColor
        data: Theme.of(context).copyWith(accentColor: Colors.grey),
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.computer),
        ),
      ),
    );
  }
}

class PackageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('使用第三方包示例'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //指定url并发起请求
            const url = 'https://github.com';
            //调用url_launcher包里的launch方法
            launch(url);
          },
          child: Text('打开GitHub'),
        ),
      ),
    );
  }
}

//C2Section3不需要做状态处理，所以此组件继承StatelessWidget即可
class StateDemo extends StatelessWidget {
  // 这个组件是整个应用的主组件
  @override
  Widget build(BuildContext context) {
    return NewHomePage(title: '无状态和有状态组件示例');
  }
}

//主页需要继承自StatefulWidget
class NewHomePage extends StatefulWidget {
  NewHomePage({Key key, this.title}) : super(key: key);

  //标题
  final String title;

  //必须重写createState方法
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//状态类必须继承State类,注意后面需要指定为<MyHomePage>
class _MyHomePageState extends State<NewHomePage> {
  int _counter = 0; //计数器

  void _incrementCounter() {
    //调用State类里的setState方法来更改状态值，使得计数器加1
    setState(() {
      //计数器变量，每次点击让其加1
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //居中布局
      body: Center(
        //垂直布局
        child: Column(
          //主轴居中对齐
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '你点击右下角按钮的次数:',
            ),
            Text(
              '$_counter', //绑定计数器的值
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, //按下+号按钮调用自增函数
        tooltip: '增加',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProviderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //使用MultiProvider可以创建多个顶层共享数据
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Counter())],
      child: MaterialApp(
        title: "Provider示例",
        theme: ThemeData(),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: FirstPage(),
      ),
    );
  }
}

//第一个页面
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第一个页面"),
        actions: <Widget>[
          FlatButton(
            child: Text("下一页"),
            //路由跳转至第二页
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SecondPage();
            })),
          )
        ],
      ),
      body: Center(
        //获取计数器中的count值
        child: Text("${Provider.of<Counter>(context).count}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //调用数据模型中的increment方法更改数据
          Provider.of<Counter>(context, listen: false).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

//第二个页面
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第二个页面"),
      ),
      body: Center(
        //获取计数器中的count值
        child: Text("${Provider.of<Counter>(context).count}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //调用数据模型中的increment方法更改数据
          Provider.of<Counter>(context, listen: false).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

/// 计数器类Counter即为数据Model,实际上就是状态。
/// Counter不仅储存了数据，而且还包含了更改数据的方法，并暴露相关数据。
/// 使用mixin混入ChangeNotifier类，这个类能够自动管理所有听众。
/// 当调用notifyListeners时，它会通知所有听众进行刷新。
class Counter with ChangeNotifier {
  //存储数据
  int _count = 0;

  //提供外部能够访问的数据
  int get count => _count;

  //提供更改数据的方法
  void increment() {
    _count++;
    //通知所有听众进行刷新
    notifyListeners();
  }
}

class HttpDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('http请求示例'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //请求后台url路径(IP + PORT + 请求接口)
            var url = 'https://www.wanandroid.com/article/list/0/json';
            //向后台发起get请求 response为返回对象
            http.get(url).then((response) {
              print("状态： ${response.statusCode}");
              print("正文： ${response.body}");
            });
          },
          child: Text('发起http请求'),
        ),
      ),
    );
  }
}

class HttpClientDemo extends StatelessWidget {
  //获取数据 此方法需要异步执行async/await
  void getHttpClientData() async {
    try {
      //实例化一个HttpClient对象
      HttpClient httpClient = HttpClient();

      //发起请求
      HttpClientRequest request = await httpClient
          .getUrl(Uri.parse("https://www.wanandroid.com/article/list/0/json"));

      //等待服务器返回数据
      HttpClientResponse response = await request.close();

      //使用utf8.decoder从response里解析数据
      var result = await response.transform(utf8.decoder).join();
      //输出响应头
      print(result);

      //httpClient关闭
      httpClient.close();
    } catch (e) {
      print("请求失败：$e");
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HttpClient请求'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("发起HttpClient请求"),
          onPressed: getHttpClientData,
        ),
      ),
    );
  }
}

class DioDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("dio示例")),
      body: Center(
          child: RaisedButton(
              onPressed: () async {
                try {
                  Response response = await Dio().get("http://www.baidu.com");
                  print(response.statusCode);
                } catch (e) {
                  print(e);
                }
              },
              child: Text("使用dio请求百度"))),
    );
  }
}
