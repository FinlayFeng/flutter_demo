import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Chapter4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      MaterialAppDemo(),
      ScaffoldDemo(),
      AppBarDemo(),
      BottomNavigationBarDemo(),
      TabBarDemo(),
      TabControllerDemo(),
      DrawerDemo(),
      FloatingActionBarDemo(),
      FlatButtonDemo(),
      PopupMenuButtonDemo(),
      SimpleDialogDemo(),
      AlertDialogDemo(),
      SnackBarDemo(),
      TextFieldDemo(),
      CardDemo(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('MaterialDesign风格组件'),
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

// 这是一个可改变的Widget
class MaterialAppDemo extends StatefulWidget {
  @override
  _MaterialAppDemo createState() => _MaterialAppDemo();
}

class _MaterialAppDemo extends State<MaterialAppDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MaterialApp示例'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '主页',
              style: TextStyle(fontSize: 48.0),
            ),
            RaisedButton(
              onPressed: () {
                //路由跳转到新页面
                Navigator.push(context, new MaterialPageRoute(
                      builder: (context) => new NewPage(),
                    ));
              },
              child: Text(
                '点击跳转到新页面',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 新的路由页面
class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('这是新的一页'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // 返回
            Navigator.pop(context);
          },
          child: Text(
            '点击返回',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}

// Scaffold脚手架组件示例
class ScaffoldDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //头部元素 比如：左侧返回按钮 中间标题 右侧菜单
      appBar: AppBar(
        title: Text('Scaffold脚手架组件示例'),
      ),
      //视图内容部分 通常作为应用页面的主显示区域
      body: Center(
        child: Text('Scaffold'),
      ),
      //底部导航栏
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
        ),
      ),
      //添加FAB按钮
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: '增加',
        child: Icon(Icons.add),
      ),
      //FAB按钮居中展示
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// AppBar应用按钮示例
class AppBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //应用按钮
      appBar: AppBar(
        //左侧图标
//        leading: Icon(Icons.list),
        //标题
        title: Text('AppBar应用按钮示例'),
        //操作按钮集
        actions: <Widget>[
          //图标按钮
          IconButton(
            icon: Icon(Icons.search),
            tooltip: '搜索',
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            tooltip: '添加',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// BottomNavigationBar示例
class BottomNavigationBarDemo extends StatefulWidget {
  BottomNavigationBarDemo({Key key}) : super(key: key);

  @override
  _BottomNavigationBarDemo createState() => _BottomNavigationBarDemo();
}

class _BottomNavigationBarDemo extends State<BottomNavigationBarDemo> {
  //当前选中项的索引
  int _selectedIndex = 1;

  //导航栏按钮选中对应数据
  final _widgetOptions = [
    Text('Index 0: 通讯录'),
    Text('Index 1: 电话'),
    Text('Index 2: 信息'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //顶部应用按钮
      appBar: AppBar(
        title: Text('BottomNavigationBar示例'),
      ),
      //中间内容显示区域
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex), //居中显示某一个文本
      ),
      //底部导航按钮集
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          //底部导航按钮项 包含图标及文本
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), title: Text('通讯录')),
          BottomNavigationBarItem(icon: Icon(Icons.phone), title: Text('电话')),
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('信息')),
        ],
        currentIndex: _selectedIndex, //当前选中项的索引
        fixedColor: Colors.blue, //选项中项的颜色
        onTap: _onItemTapped, //选择按下处理
      ),
    );
  }

  //选择按下处理 设置当前索引为index值
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

//DefaultTabController示例
class TabBarDemo extends StatelessWidget {
  //选项卡数据
  final List<Tab> myTabs = <Tab>[
    Tab(text: '选项卡一'),
    Tab(text: '选项卡二'),
  ];

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: myTabs.length,
      child: new Scaffold(
        appBar: AppBar(
          //页面标题
          title: Text("DefaultTabController示例"),
          //添加选项卡按钮 注意此bottom表示在AppBar的底部,在整个页面上来看还处于顶部区域
          bottom: TabBar(
            tabs: myTabs,
            indicatorColor: Colors.white,
            // Whether this tab bar can be scrolled horizontally.
            // If [isScrollable] is true, then each tab is as wide as needed for its label
            // and the entire [TabBar] is scrollable. Otherwise each tab gets an equal
            // share of the available space.
            isScrollable: false,
          ),
        ),
        //添加选项卡视图即页面中间内容显示区域
        body: TabBarView(
          //使用map迭代显示中间内空
          children: myTabs.map((Tab tab) {
            return Center(child: Text(tab.text));
          }).toList(),
        ),
      ),
    );
  }
}

// TabController示例
class TabControllerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //添加DefaultTabController关联TabBar及TabBarView
    return DefaultTabController(
      length: items.length, //传入选项卡数量
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabController示例'),
          //选项卡按钮
          bottom: TabBar(
            isScrollable: true, //设置为可以滚动
            indicatorColor: Colors.blue,
            //迭代添加选项卡按钮子项
            tabs: items.map((ItemView item) {
              //选项卡按钮由文本及图标组成
              return Tab(
                text: item.title,
                icon: Icon(item.icon),
              );
            }).toList(),
          ),
        ),
        //添加选项卡视图
        body: TabBarView(
          //迭代显示选项卡视图
          children: items.map((ItemView item) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SelectedView(item: item),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// 视图项数据
class ItemView {
  const ItemView({this.title, this.icon}); //构造方法 传入标题及图标
  final String title; //标题
  final IconData icon; //图标
}

// 选项卡的类目
const List<ItemView> items = const <ItemView>[
  const ItemView(title: '自驾', icon: Icons.directions_car),
  const ItemView(title: '自行车', icon: Icons.directions_bike),
  const ItemView(title: '轮船', icon: Icons.directions_boat),
  const ItemView(title: '公交车', icon: Icons.directions_bus),
  const ItemView(title: '火车', icon: Icons.directions_railway),
  const ItemView(title: '步行', icon: Icons.directions_walk),
];

// 被选中的视图
class SelectedView extends StatelessWidget {
  const SelectedView({Key key, this.item}) : super(key: key);

  //视图数据
  final ItemView item;

  @override
  Widget build(BuildContext context) {
    //获取文本主题样式
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    //添加卡片组件 展示有质感
    return Card(
      //卡片颜色
      color: Colors.grey,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, //垂直方向最小化处理
          crossAxisAlignment: CrossAxisAlignment.center, //水平方向居中对齐
          children: <Widget>[
            Icon(item.icon, size: 128.0, color: textStyle.color),
            Text(item.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}

// Drawer抽屉组件示例
class DrawerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Drawer抽屉组件示例'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            //设置用户信息 头像、用户名、Email等
            UserAccountsDrawerHeader(
              accountName: new Text(
                "张三",
              ),
              accountEmail: new Text(
                "zhangsan@163.com",
              ),
              //设置当前用户头像
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new AssetImage("image1.png"),
              ),
              onDetailsPressed: () {},
              // 属性本来是用来设置当前用户的其他账号的头像 这里用来当QQ二维码图片展示
              otherAccountsPictures: <Widget>[
                new Container(
                  child: Image.asset('image4.png'),
                ),
              ],
            ),
            ListTile(
              leading: new CircleAvatar(child: Icon(Icons.photo_camera)),
              title: Text('拍照'),
            ),
            ListTile(
              leading: new CircleAvatar(child: Icon(Icons.photo)),
              title: Text('我的相册'),
            ),
            ListTile(
              leading: new CircleAvatar(child: Icon(Icons.phone)),
              title: Text('联系客服'),
            ),
          ],
        ),
      ),
    );
  }
}

// FloatingActionButton示例
class FloatingActionBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FloatingActionButton示例'),
      ),
      body: Center(
        child: Text(
          '请点击FloatingActionButton',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton(
          child: const Icon(Icons.add),
          //提示信息
          tooltip: "请点击FloatingActionButton",
          //前景色为白色
          foregroundColor: Colors.white,
          //背景色为蓝色
          backgroundColor: Colors.blue,
          //未点击阴影值
          elevation: 7.0,
          //点击阴影值
          highlightElevation: 14.0,
          onPressed: () {
            //点击回调事件 弹出一句提示语句
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("你点击了FloatingActionButton"),
            ));
          },
          mini: false,
          //圆形边
          shape: CircleBorder(),
          isExtended: false,
        );
      }),
      //居中放置 位置可以设置成左中右
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

// FlatButton扁平按钮组件示例
class FlatButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlatButton扁平按钮组件示例'),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            Fluttertoast.showToast(
                msg: "点击了FlatButton",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black45,
                textColor: Colors.white,
                fontSize: 16.0);
          },
          child: Text(
            'FlatButton',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}

// 菜单项
enum More { GroupChat, AddFriend, Scan, ReceiveAndPay, help }

// PopupMenuButton组件示例
class PopupMenuButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PopupMenuButton组件示例'),
        actions: <Widget>[
          PopupMenuButton<More>(
            onSelected: (More result) {},
            // 菜单项构造器
            itemBuilder: (BuildContext context) => <PopupMenuEntry<More>>[
              const PopupMenuItem<More>(
                // 菜单项
                value: More.GroupChat,
                child: Text('发起群聊'),
              ),
              const PopupMenuItem<More>(
                value: More.AddFriend,
                child: Text('添加朋友'),
              ),
              const PopupMenuItem<More>(
                value: More.Scan,
                child: Text('扫一扫'),
              ),
              const PopupMenuItem<More>(
                value: More.ReceiveAndPay,
                child: Text('收付款'),
              ),
              const PopupMenuItem<More>(
                value: More.help,
                child: Text('帮助与反馈'),
              ),
            ],
          ),
        ],
      ),
      body: Center(),
    );
  }
}

// SimpleDialog组件示例
class SimpleDialogDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SimpleDialog组件示例'),
      ),
      body: Center(
        child: FlatButton(
            onPressed: () async{
              // 获取点击信息
              var result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: const Text('打开SimpleDialog'),
                      children: <Widget>[
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.of(context).pop('-');
                          },
                          child: const Text('第一行信息'),
                        ),
                        SimpleDialogOption(
                          child: const Text('第二行信息'),
                          onPressed: () {
                            Navigator.of(context).pop('二');
                          },
                        ),
                      ],
                    );
                  });
              print('$result');
            },
            child: Text(
              '打开SimpleDialog',
              style: TextStyle(fontSize: 24.0),
            )),
      ),
    );
  }
}

// AlertDialog组件示例
class AlertDialogDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AlertDialog组件示例'),
        ),
        body: Center(
          //添加对话框
          child: FlatButton(
              onPressed: () async {
                // 获取点击信息
                var result = await showDialog(
                    context: context,
                    // 控制点击空白处无效
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        //对话框标题
                        title: Text('提示'),
                        //对话框内容部分
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('是否要删除?'),
                              Text('一旦删除数据不可恢复！'),
                            ],
                          ),
                        ),
                        //对话框操作按钮
                        actions: <Widget>[
                          FlatButton(
                            child: Text('确定'),
                            onPressed: () {
                              Navigator.of(context).pop('确定');
                            },
                          ),
                          FlatButton(
                            child: Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop('取消');
                            },
                          ),
                        ],
                      );
                    });
                print('$result');
              },
              child: Text(
                '打开AlertDialog',
                style: TextStyle(fontSize: 24.0),
              )),
        ),
      );
  }
}

// SnackBar示例
class SnackBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SnackBar示例'),
        ),
        body: Center(
          child: Text(
            'SnackBar示例',
            style: TextStyle(fontSize: 28.0),
          ),
        ),
        //FAB按钮
        floatingActionButton: Builder(builder: (BuildContext context) {
          return FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              //点击回调事件 弹出一句提示语句
              Scaffold.of(context).showSnackBar(SnackBar(
                //提示信息内容部分
                content: Text("显示SnackBar"),
              ));
            },
            shape: CircleBorder(),
          );
        }),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerFloat, //居中放置 位置可以设置成左中右
    );
  }
}

// TextField组件示例
class TextFieldDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //添加文本编辑控制器 监听文本输入内容变化
    final TextEditingController controller = TextEditingController();
    controller.addListener(() {
      print('你输入的内容为: ${controller.text}');
    });

    return Scaffold(
        appBar: AppBar(
          title: Text('TextField组件示例'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              //绑定controller
              controller: controller,
              //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
              maxLength: 30,
              //最大行数
              maxLines: 1,
              //是否自动更正
              autocorrect: true,
              //是否自动对焦
              autofocus: true,
              //是否是密码
              obscureText: false,
              //文本对齐方式
              textAlign: TextAlign.center,
              //输入文本的样式
              style: TextStyle(fontSize: 26.0, color: Colors.blue),
              //文本内容改变时回调
              onChanged: (text) {
                print('文本内容改变时回调 $text');
              },
              //内容提交时回调
              onSubmitted: (text) {
                print('内容提交时回调 $text');
              },
              enabled: true, //是否禁用
              decoration: InputDecoration(//添加装饰效果
                  fillColor: Colors.grey,//添加灰色填充色
                  filled: true,
                  helperText: '用户名',
                  prefixIcon: Icon(Icons.person),//左侧图标
                  suffixText: '用户名'),//右侧文本提示
            ),
          ),
        ),
    );
  }
}

// Card布局示例
class CardDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var card = SizedBox(
      //限定高度
      height: 250.0,
      //添加Card组件
      child: Card(
        // 外边距
        margin: EdgeInsets.all(20.0),
        // 背景
        color: Colors.purpleAccent,
        // Z轴的高度，设置Card的阴影
        elevation: 20.0,
        // shape，R角
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        //对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿
        clipBehavior: Clip.antiAlias,
        semanticContainer: false,
        //垂直布局
        child: Column(
          children: <Widget>[
            ListTile(
              //标题
              title: Text(
                '深圳市南山区深南大道',style: TextStyle(fontWeight: FontWeight.w300),
              ),
              //子标题
              subtitle: Text('XX有限公司'),
              //左侧图标
              leading: Icon(
                Icons.home,
                color: Colors.lightBlue,
              ),
            ),
            //分隔线
            Divider(),
            ListTile(
              title: Text(
                '深圳市罗湖区沿海大道',style: TextStyle(fontWeight: FontWeight.w300),
              ),
              subtitle: Text('XX培训机构'),
              leading: Icon(
                Icons.school,
                color: Colors.lightBlue,
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Card布局示例'),
      ),
      body: Center(
        child: card,
      ),
    );
  }
}
