import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chapter7 extends StatefulWidget {
  @override
  _Chapter8 createState() => _Chapter8();
}

class _Chapter8 extends State<Chapter7> {
  final List<String> items =
      new List<String>.generate(30, (i) => "列表项 ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('手势示例'),
        ),
        // 一定要把被触摸的组件放在GestureDetector里面
        body: GestureDetector(
            onTap: () => print("点击屏幕"),
            onTapDown: (details) => print("点击事件开始"),
            onTapUp: (details) => print("手指离开屏幕"),
            onTapCancel: () => print("点击事件结束"),
            onDoubleTap: () => print("双击"),
            onLongPress: () => print("长按"),
            onVerticalDragStart: (details) => print("onVerticalDragStart"),
            onVerticalDragUpdate: (details) => print("onVerticalDragUpdate"),
            onVerticalDragEnd: (details) => print("onVerticalDragEnd"),
            onVerticalDragCancel: () => print("onVerticalDragCancel"),
            onVerticalDragDown: (details) => print("onVerticalDragCancel"),
            onHorizontalDragStart: (details) => print("onHorizontalDragStart"),
            onHorizontalDragUpdate: (details) =>
                print("onHorizontalDragUpdate"),
            onHorizontalDragEnd: (details) => print("onHorizontalDragEnd"),
            onHorizontalDragCancel: () => print("onHorizontalDragCancel"),
            onHorizontalDragDown: (details) => print("onHorizontalDragDown"),
            // 添加容器接收触摸动作
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                // 提取出被删除的项
                final item = items[index];
                // 返回一个可以被删除的列表项
                return new Dismissible(
                    key: new Key(item),
                    // 被删除回调
                    onDismissed: (direction) {
                      // 移除指定索引项
                      items.removeAt(index);
                      // 底部弹出消息提示当前项被删除了
                      Scaffold.of(context).showSnackBar(
                          new SnackBar(content: new Text("$item 被删除了")));
                    },
                    child: Container(
                        child: new ListTile(
                          title: new Text('$item'),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: Colors.grey)),
                        )));
              },
            )
        )
    );
  }
}
