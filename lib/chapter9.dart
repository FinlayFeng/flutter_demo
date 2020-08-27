import 'dart:io';
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class Chapter9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      NavigationDemo(),
      SharedPreferencesDemo(),
      SQFLiteDemo(),
      FileDemo(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('路由导航及数据持久化'),
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

class NavigationDemo extends StatefulWidget {
  final String title = '传递数据示例';
  final List<Product> list =
      new List<Product>.generate(20, (i) => new Product(i + 1, '商品 ${i + 1}'));

  @override
  State<StatefulWidget> createState() => ProductList(list);
}

class Product {
  final int id;
  final String name;

  Product(this.id, this.name);
}

class ProductList extends State<NavigationDemo> {
  List<Product> list;

  ProductList(this.list);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return new ListTile(
            title: new Text(item.name),
            onTap: () async {
              final int result = await Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new ProductDetail(product: item),
                  ));
              if (result == item.id) {
                list.removeAt(index);
                setState(() {});
                Scaffold.of(context).showSnackBar(
                    new SnackBar(content: new Text(item.name + "被购买了")));
              }
            },
          );
        },
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;

  ProductDetail({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品详情"),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text("${product.name}"),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context, product.id);
              },
              child: Text('buy'),
            )
          ])),
    );
  }
}

// 本地存储 使用key-value存储
class SharedPreferencesDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SharedPreferencesDemo();
}

class _SharedPreferencesDemo extends State<SharedPreferencesDemo> {
  // 实例化本地存储对象
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // 呢称及选择语言的值
  var controller = TextEditingController();
  bool valueDart = false;
  bool valueJs = false;
  bool valueJava = false;

  @override
  void initState() {
    super.initState();
    initFromCache();
  }

  @override
  void dispose() {
    super.dispose();
    controller = null;
  }

  // 从缓存中获取信息填充
  void initFromCache() async {
    final SharedPreferences prefs = await _prefs;
    // 根据键key获取本地存储的值value
    final valueNickname = prefs.getString("key_nickname");
    final valueDart = prefs.getBool("key_dart");
    final valueJs = prefs.getBool("key_js");
    final valueJava = prefs.getBool("key_java");

    // 获取到缓存中的值后，使用setState更新界面信息
    setState(() {
      controller.text = (valueNickname == null ? "" : valueNickname);
      this.valueDart = (valueDart == null ? false : valueDart);
      this.valueJs = (valueJs == null ? false : valueJs);
      this.valueJava = (valueJava == null ? false : valueJava);
    });
  }

  // 保存界面的输入选择信息
  void saveInfo(String valueNickname) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("key_nickname", valueNickname);
    prefs.setBool("key_dart", valueDart);
    prefs.setBool("key_js", valueJs);
    prefs.setBool("key_java", valueJava);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SharedPreferences示例'),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: '昵称:',
                  hintText: '请输入名称',
                ),
              ),
              Text('你喜欢的编程语言'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Dart'),
                  Switch(
                    value: valueDart,
                    onChanged: (isChanged) {
                      // 设置状态改变要存储的值
                      setState(() {
                        this.valueDart = isChanged;
                      });
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('JavaScript'),
                  Switch(
                    value: valueJs,
                    onChanged: (isChanged) {
                      setState(() {
                        this.valueJs = isChanged;
                      });
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Java'),
                  Switch(
                    value: valueJava,
                    onChanged: (isChanged) {
                      setState(() {
                        this.valueJava = isChanged;
                      });
                    },
                  )
                ],
              ),
              MaterialButton(
                child: Text('保存'),
                onPressed: () {
                  saveInfo(controller.text);
                },
              ),
            ],
          ),
        ));
  }
}

// 数据库存储
class SQFLiteDemo extends StatefulWidget {
  @override
  _SQFLiteDemo createState() => _SQFLiteDemo();
}

class _SQFLiteDemo extends State<SQFLiteDemo> {
  // 测试数据
  List<Client> clients = [
    Client(name: "张三", age: 20, sex: false),
    Client(name: "李四", age: 22, sex: true),
    Client(name: "王五", age: 28, sex: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sqflite示例")),
      body: FutureBuilder<List<Client>>(
        // 获取所有Client
        future: DBProvider.db.getAllClients(),
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          // 如果有数据用列表展示
          if (snapshot.hasData) {
            return ListView.builder(
              // 数据项个数 对应返回的表记录的条数
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                // 数据项Client对象
                Client item = snapshot.data[index];
                // 滑动删除组件
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  // 删除Client
                  onDismissed: (direction) {
                    // 根据id删除Client对象
                    DBProvider.db.deleteClient(item.id);
                  },
                  child: ListTile(
                    // 展示Client对象数据
                    title: Text(item.name.toString()),
                    leading: Text(item.id.toString()),
                    trailing: Checkbox(
                      onChanged: (bool value) {
                        // 更新性别
                        DBProvider.db.updateSex(item);
                        setState(() {});
                      },
                      //显示性别
                      value: item.sex,
                    ),
                  ),
                );
              },
            );
          }
          // 没有数据显示缓冲动画
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // 随机取测试数据中的一条数据作为Client对象
          Client rnd = clients[math.Random().nextInt(clients.length)];
          // 新增加一个Client对象
          await DBProvider.db.insertClient(rnd);
          setState(() {});
        },
      ),
    );
  }
}

// 客户数据模型类
class Client {
  // id
  int id;

  // 姓名
  String name;

  // 年龄
  int age;

  // 性别
  bool sex;

  Client({
    this.id,
    this.name,
    this.age,
    this.sex,
  });

  // 将JSON数据转换成数据模型
  factory Client.fromMap(Map<String, dynamic> json) => Client(
        id: json["id"],
        name: json["name"],
        age: json["age"],
        sex: json["sex"] == 1,
      );

  // 将数据模型转换成JSON
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "age": age,
        "sex": sex,
      };
}

// 数据库操作封装类
class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  // 获取Database对象
  Future<Database> get database async {
    // 使用单例模式创建Database对象
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  // 初始化数据库
  initDB() async {
    // 获取文档目录对象
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // 获取默认数据库位置(在Android上，它通常是data/data/<package_name>/databases,在iOS上，它是Documents目录)
    String path = join(documentsDirectory.path, "client.db");
    // 打开数据库 传入路径 版本号 打开完成回调函数
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      // 数据库创建完成后创建Client表
      await db.execute("CREATE TABLE Client ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "age INTEGER,"
          "sex BIT"
          ")");
    });
  }

  // 新增Client
  insertClient(Client newClient) async {
    final db = await database;
    // 获取表中最大的id再加1作为新的id
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Client");
    int id = table.first["id"];
    // 向表中插入一条数据
    var raw = await db.rawInsert(
        "INSERT Into Client (id,name,age,sex)"
        " VALUES (?,?,?,?)",
        [id, newClient.name, newClient.age, newClient.sex]);
    return raw;
  }

  // 修改性别
  updateSex(Client client) async {
    final db = await database;
    Client newClient = Client(
        id: client.id, name: client.name, age: client.age, sex: !client.sex);
    // 更新当前Client的性别
    var res = await db.update("Client", newClient.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    return res;
  }

  // 更新Client
  updateClient(Client newClient) async {
    final db = await database;
    var res = await db.update("Client", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  // 根据id获取Client
  getClient(int id) async {
    final db = await database;
    // 根据id查询表记录
    var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
    // 将查询返回的数据转换为Client对象并返回
    return res.isNotEmpty ? Client.fromMap(res.first) : null;
  }

  // 获取所有Client
  Future<List<Client>> getAllClients() async {
    final db = await database;
    var res = await db.query("Client");
    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  // 根据id删除Client
  deleteClient(int id) async {
    final db = await database;
    return db.delete("Client", where: "id = ?", whereArgs: [id]);
  }

  // 删除所有Client
  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Client");
  }
}

// 文件存储
class FileDemo extends StatefulWidget {
  @override
  _FileDemo createState() => _FileDemo();
}

class _FileDemo extends State<FileDemo> {
  // 日志id
  int logId = 0;
  // 日志内容
  String logInfo = '';
  // 文件对象
  File file;

  @override
  void initState() {
    super.initState();
    // 读取日志信息
    readLogInfo().then((String value) {
      setState(() {
        logInfo = value;
      });
    });
  }

  // 获取文件对象
  Future<File> getFile() async {
    // 获取文件所在目录路径
    String dir = (await getApplicationDocumentsDirectory()).path;
    // 创建文件
    if (file == null) {
      file = File('$dir/log.txt');
    }
    return file;
  }

  // 读取日志信息
  Future<String> readLogInfo() async {
    try {
      File file = await getFile();
      // 读取文件中存储的内容并返回
      String contents = await file.readAsString();
      return contents;
    } on FileSystemException {
      return '';
    }
  }

  // 写入日志信息
  Future<Null> writeLogInfo() async {
    // 日志id号自增
    setState(() {
      logId++;
    });
    // getFile:获取File对象
    // writeAsString:写入数据
    // FileMode:文件写入模式为追加模式这样就可以把每次写入的信息记录起来
    // 两个await是因为有两个异步操作
    await (await getFile())
        .writeAsString('日志信息:$logId\n', mode: FileMode.append);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('文件存储示例')),
      body: Center(
        child: Text('$logInfo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: writeLogInfo,
        tooltip: '写入日志',
        child: Icon(Icons.add),
      ),
    );
  }
}
