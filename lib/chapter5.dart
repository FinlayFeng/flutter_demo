import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chapter5 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      ActivityIndicatorDemo(),
      AlertDialogDemo(),
      ButtonDemo(),
      NavigationDemo(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Cupertino风格组件'),
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

class ActivityIndicatorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CupertinoActivityIndicator示例'),
        ),
        body: Center(
          child: CupertinoActivityIndicator(
            radius: 60.0,//值越大加载的图形越大
          ),
        ),
    );
  }
}

class AlertDialogDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CupertinoAlertDialog组件示例'),
        ),
        body: Center(
          //添加对话框
          child: CupertinoAlertDialog(
            title: Text('提示'), //对话框标题
            content: SingleChildScrollView(
              //对话框内容部分
              child: ListBody(
                children: <Widget>[
                  Text('是否要删除?'),
                  Text('一旦删除数据不可恢复！'),
                ],
              ),
            ),
            //对话框动作按钮
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('确定'),
                onPressed: () {},
              ),
              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: () {},
              ),
            ],
          ),
        ),
    );
  }
}

class ButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CupertinoButton组件示例'),
        ),
        body: Center(
          //Cupertino风格按钮
          child: CupertinoButton(
            child: Text(//按钮label
              'CupertinoButton',
            ),
            color: Colors.blue,//按钮颜色
            onPressed: (){},//按下事件回调
          ),
        ),
    );
  }
}

class NavigationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //最外层导航选项卡
    return CupertinoTabScaffold(
      //底部选项卡
      tabBar: CupertinoTabBar(
        backgroundColor: CupertinoColors.darkBackgroundGray, //选项卡背景色
        items: [
          //选项卡项 包含图标及文字
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text('主页'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.conversation_bubble),
            title: Text('聊天'),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        //选项卡绑定的视图
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return HomePage();
                break;
              case 1:
                return ChatPage();
                break;
              default:
                return Container();
            }
          },
        );
      },
    );
  }
}

//主页
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      //基本布局结构，包含内容和导航栏
      navigationBar: CupertinoNavigationBar(
        //导航栏 只包含中部标题部分
        backgroundColor: CupertinoColors.lightBackgroundGray,
        middle: Text("主页", style: Theme.of(context).textTheme.button),
      ),
      child: Center(
        child: Text(
          '主页',
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}

//聊天页面
class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        //导航栏 包含左中右三部分
        middle: Text("聊天面板", style: Theme.of(context).textTheme.button),//中间标题
        trailing: Icon(CupertinoIcons.add),//右侧按钮
        leading: Icon(CupertinoIcons.back),//左侧按钮
      ),
      child: Center(
        child: Text(
          '聊天面板',
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}