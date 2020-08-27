import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chapter3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      ContainerDemo(),
      ImageDemo(),
      TextDemo(),
      RaisedButtonDemo(),
      ListViewDemo(),
      RowListViewDemo(),
      ListViewBuilder(),
      GridViewDemo(),
      TableDemo(),
      FormDemo(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('常用组件'),
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

class ContainerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('容器组件示例'),
      ),
      body: new Center(
        child: Container(
          width: 200.0,
          height: 200.0,
          // 添加边框装饰效果
          decoration: BoxDecoration(
              color: Colors.grey,
              // 设置上下左右四个边框样式
              border: new Border.all(
                color: Colors.blue,
                width: 8.0,
              ),
              // 边框弧度
              borderRadius: const BorderRadius.all(const Radius.circular(8.0))),
          child: Text(
            'flutter',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28.0),
          ),
        ),
      ),
    );
  }
}

class ImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片组件示例'),
      ),
      body: new Center(
        // 添加网络图片
        child: new Image.network(
          // 图片url
          'https://flutter-io.cn/favicon.ico',
          // 填充模式
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class TextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文本组件示例'),
      ),
      body: new Column(
        children: <Widget>[
          new Text(
            '红色+黑色删除线+25号字体',
            style: new TextStyle(
              color: const Color(0xffff0000),
              decoration: TextDecoration.lineThrough,
              decorationColor: const Color(0xff000000),
              fontSize: 25.0,
            ),
          ),
          new Text(
            '橙色+下划线+24号字体',
            style: new TextStyle(
              color: const Color(0xffff9900),
              decoration: TextDecoration.underline,
              fontSize: 24.0,
            ),
          ),
          new Text(
            '虚线上划线+23号字体+倾斜',
            style: new TextStyle(
              decoration: TextDecoration.overline,
              decorationStyle: TextDecorationStyle.dashed,
              fontSize: 23.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          new Text(
            '24号字体+加粗+字间距',
            style: new TextStyle(
              fontSize: 24.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              letterSpacing: 6.0,
            ),
          ),
        ],
      ),
    );
  }
}

class RaisedButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text('图标及按钮组件示例'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 图标组件
              new Icon(
                Icons.phone,
                color: Colors.green[500],
                size: 40.0,
              ),
              // 图标按钮组件
              new IconButton(
                  icon: Icon(
                    Icons.volume_up,
                    size: 40.0,
                  ),
                  tooltip: '按下操作',
                  onPressed: () {
                    print('IconButton按下操作');
                  }),
              //凸起按钮组件
              new RaisedButton(
                child: new Text('RaisedButton组件'),
                onPressed: () {
                  print('RaisedButton按下操作');
                },
              )
            ],
          ),
        ));
  }
}

class ListViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基础列表示例'),
      ),
      // 添加基础列表
      body: new ListView(
        // 添加静态数据
        children: <Widget>[
          ListTile(
            // 添加文本
            title: Text('Alarm'),
            // 添加图标
            leading: Icon(Icons.alarm),
          ),
          ListTile(
            title: Text('Phone'),
            leading: Icon(Icons.phone),
          ),
          ListTile(
            title: Text('Airplay'),
            leading: Icon(Icons.airplay),
          ),
          ListTile(
            title: Text('Volume_up'),
            leading: Icon(Icons.volume_up),
          ),
          ListTile(
            title: Text('Wifi'),
            leading: Icon(Icons.wifi),
          ),
          ListTile(
            title: Text('Android'),
            leading: Icon(Icons.android),
          ),
          ListTile(
            title: Text('Battery_full'),
            leading: Icon(Icons.battery_full),
          ),
          ListTile(
            title: Text('Backspace'),
            leading: Icon(Icons.backspace),
          ),
          ListTile(
            title: Text('Work'),
            leading: Icon(Icons.work),
          ),
        ],
      ),
    );
  }
}

class RowListViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('水平列表示例'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: double.infinity,
        child: ListView(
          // 设置水平方向排列
          scrollDirection: Axis.horizontal,
          // 添加子元素
          children: <Widget>[
            Container(
              width: 100.0,
              color: Colors.lightBlue,
            ),
            Container(
              width: 100.0,
              color: Colors.amber,
            ),
            Container(
              width: 160.0,
              color: Colors.green,
              child: Column(
                children: [
                  Text(
                    '水平',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36.0,
                    ),
                  ),
                  Text(
                    '列表',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36.0,
                    ),
                  ),
                  Icon(Icons.list),
                  Icon(Icons.list),
                  Icon(Icons.list),
                  Icon(Icons.list),
                ],
              ),
            ),
            Container(
              width: 100.0,
              color: Colors.deepOrangeAccent,
            ),
            Container(
              width: 100.0,
              color: Colors.black,
            ),
            Container(
              width: 100.0,
              color: Colors.pinkAccent,
            ),
          ],
        ),
      ),
    );
  }
}

class ListViewBuilder extends StatelessWidget {
  // 使用generate()生成500条数据并初始化列表数据集
  final List<String> items =
      new List<String>.generate(500, (index) => "Item $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('长列表组件示例'),
      ),
      // 使用ListView.builder来构造列表项
      body: new ListView.builder(
        shrinkWrap: true,
        // 列表长度
        itemCount: items.length,
        // 列表项构造器
        itemBuilder: (context, index) {
//          return new ListTile(
//            leading: new Icon(Icons.phone),
//            title: new Text('${items[index]}'),
//          );
          return Container(
            child: new ListTile(
              leading: new Icon(Icons.phone),
              title: new Text('${items[index]}'),
            ),
            // 添加分隔线
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
            ),
          );
        },
      ),
    );
  }
}

class GridViewDemo extends StatelessWidget {
  final List<String> items =
      new List<String>.generate(100, (index) => "Item $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('网格列表组件示例'),
      ),
      // 使用GridView.builder构建网格
      body: new GridView.builder(
//        primary: false,
//        // 四周增加间隙
//        padding: const EdgeInsets.all(20.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.0,
          crossAxisCount: 3,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            child: Center(
              child: new Text('${items[index]}'),
            ),
            // 添加分隔线
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
          );
        },
      ),
    );
  }
}

class TableDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table布局示例'),
      ),
      // 表格居中
      body: Center(
        // 添加表格
        child: Table(
          // 设置表格有多少列,并且指定列宽
          columnWidths: const <int, TableColumnWidth>{
            // 指定索引及固定列宽
            0: FixedColumnWidth(120.0),
            1: FixedColumnWidth(80.0),
            2: FixedColumnWidth(80.0),
            3: FixedColumnWidth(80.0),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          // 设置表格边框样式
          border: TableBorder.all(
              color: Colors.black38, width: 2.0, style: BorderStyle.solid),
          children: <TableRow>[
            // 添加第一行数据
            TableRow(children: [
              // 设置居中
              Center(
                  child: Text(
                '姓名',
                textAlign: TextAlign.center,
              )),
              Text(
                '性别',
                textAlign: TextAlign.center,
              ),
              Text('年龄'),
              Text('身高'),
            ]),
            // 添加第二行数据
            TableRow(
              /**/
              children: <Widget>[
                Text('张三'),
                Text('男'),
                Text('26'),
                Text('172'),
              ],
            ),
            // 添加第三行数据
            TableRow(
              children: <Widget>[
                Text('李四'),
                Text('男'),
                Text('28'),
                Text('178'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FormDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<FormDemo> {
  // 全局Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();

  String userName;
  String password;

  void login() {
    // 读取当前的Form状态
    var loginForm = loginKey.currentState;
    // 验证Form表单
    if (loginForm.validate()) {
      loginForm.save();
      print('userName:' + userName + ', password:' + password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('表单组件示例'),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(16.0),
            child: new Form(
                key: loginKey,
                child: new Column(
                  children: <Widget>[
                    new TextFormField(
                      decoration: new InputDecoration(labelText: '请输入用户名'),
                      onSaved: (value) {
                        userName = value;
                      },
                      onFieldSubmitted: (value) {},
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(labelText: '请输入密码'),
                      obscureText: true,
                      validator: (value) {
                        return value.length < 6 ? "密码长度不够6位" : null;
                      },
                      onSaved: (value) {
                        password = value;
                      },
                    ),
                    new Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      width: double.infinity,
                      height: 45.0,
                      child: new RaisedButton(
                        onPressed: login,
                        child: new Text(
                          '登录',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
