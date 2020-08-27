import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chapter6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      ContainerDemo(),
      CenterDemo(),
      PaddingDemo(),
      AlignDemo(),
      RowDemo(),
      ColumnDemo(),
      FittedBoxDemo(),
      StackAlignmentDemo(),
      StackPositionedDemo(),
      IndexedStackDemo(),
      OverflowBoxDemo(),
      SizedBoxDemo(),
      ConstrainedBoxDemo(),
      LimitedBoxDemo(),
      AspectRatioDemo(),
      FractionallySizedBoxDemo(),
      TransformDemo(),
      BaselineDemo(),
      OffstageDemo(),
      WrapDemo(),
      MixDemo()
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('页面布局'),
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

// Container容器布局示例
class ContainerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //返回一个Container对象
    Widget container = Container(
      //添加装饰效果
      decoration: BoxDecoration(
        //背景色
        color: Colors.grey,
      ),
      //子元素指定为一个垂直水平嵌套布局的组件
      child: Column(
        children: <Widget>[
          //水平布局
          Row(
            children: <Widget>[
              //使用Expanded防止内容溢出
              Expanded(
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  //添加边框样式
                  decoration: BoxDecoration(
                    //上下左右边框设置为宽度10.0 颜色为蓝灰色
                    border: Border.all(width: 10.0, color: Colors.blueGrey),
                    //上下左右边框弧度设置为8.0
                    borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
                  ),
                  //上下左右增加边距
                  margin: const EdgeInsets.all(4.0),
                  //添加图片
                  child: Image.asset('images/image1.png'),
                ),
              ),
              Expanded(
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 10.0, color: Colors.blueGrey),
                    borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
                  ),
                  margin: const EdgeInsets.all(4.0),
                  child: Image.asset('images/image2.png'),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 10.0, color: Colors.blueGrey),
                    borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
                  ),
                  margin: const EdgeInsets.all(4.0),
                  child: Image.asset('images/image3.png'),
                ),
              ),
              Expanded(
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 10.0, color: Colors.blueGrey),
                    borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
                  ),
                  margin: const EdgeInsets.all(4.0),
                  child: Image.asset('images/image4.png'),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Container容器布局示例'),
      ),
      body: container,
    );
  }
}

// Center居中布局示例
class CenterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Center居中布局示例'),
      ),
      //居中组件 位于body的中心位置
      body: Center(
        //添加文本
        child: Text(
          'Hello Flutter',
          style: TextStyle(
            fontSize: 36.0,
          ),
        ),
      ),
    );
  }
}

// Padding填充布局示例
class PaddingDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Padding填充布局示例'),
      ),
      body: Center(
        //添加容器 外框
        child: Container(
          width: 300.0,
          height: 300.0,
          //容器内边距上下左右设置为12.0
          padding: EdgeInsets.all(12.0),
          //添加边框
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.green,
              width: 8.0,
            ),
          ),
          //添加容器 内框
          child: Container(
            width: 200.0,
            height: 200.0,
            //添加边框
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.blue,
                width: 8.0,
              ),
            ),
            //添加图标
            child: FlutterLogo(),
          ),
        ),
      ),
    );
  }
}

// Align对齐布局示例
class AlignDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Align对齐布局示例'),
      ),
      body: Stack(
          children: <Widget>[
            // 左上角
            Align(
              // 对齐属性 确定位置
              alignment: FractionalOffset(0.0, 0.0),
//              alignment: FractionalOffset.topLeft,
              // 添加图片
              child: Image.asset('images/image1.png',width: 60.0,height: 60.0,),
            ),
            // 顶部中心
            Align(
              alignment: FractionalOffset.topCenter,
              child: Image.asset('images/image2.png',width: 60.0,height: 60.0,),
            ),
            // 右上角
            Align(
              alignment: FractionalOffset(1.0,0.0),
//              alignment: FractionalOffset.topRight,
              child: Image.asset('images/image3.png',width: 60.0,height: 60.0,),
            ),
            // 左边缘中心
            Align(
              alignment: FractionalOffset.centerLeft,
              child: Image.asset('images/image4.png',width: 60.0,height: 60.0,),
            ),
            // 水平垂直方向居中
            Align(
              alignment: FractionalOffset.center,
              child: Image.asset('images/image4.png',width: 60.0,height: 60.0,),
            ),
            // 右边缘中心
            Align(
              alignment: FractionalOffset.centerRight,
              child: Image.asset('images/image4.png',width: 60.0,height: 60.0,),
            ),
            // 左下角
            Align(
              alignment: FractionalOffset(0.02,0.98),
              child: Image.asset('images/image5.png',width: 60.0,height: 60.0,),
            ),
            // 底部中心
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Image.asset('images/image6.png',width: 60.0,height: 60.0,),
            ),
            // 右下角
            Align(
              alignment: FractionalOffset(0.98,0.98),
//              alignment: FractionalOffset.bottomRight
              child: Image.asset('images/image7.png',width: 60.0,height: 60.0,),
            ),
          ]
      ),
    );
  }
}

// Row水平布局示例
class RowDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('水平布局示例'),
      ),
      //水平布局
      body: Row(
        children: <Widget>[
          Expanded(
            child: Text('左侧文本', textAlign: TextAlign.center),
          ),
          Expanded(
            child: Text('中间文本', textAlign: TextAlign.center),
          ),
          //右侧图标
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              child: FlutterLogo(),
            ),
          ),
        ],
      ),
    );
  }
}

// 垂直布局示例
class ColumnDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('垂直布局示例'),
      ),
      //文本按垂直方向排列
      body: Column(
        //水平方向靠左对齐
//        crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Flutter是谷歌的移动UI框架'),
          Text('可以快速在iOS和Android上构建高质量的原生用户界面'),
          Text('Flutter可以与现有的代码一起工作。在全世界'),
          Text('Flutter正在被越来越多的开发者和组织使用'),
          Text('并且Flutter是完全免费、开源的。'),
          Text('Flutter!', style: TextStyle(fontSize: 36.0,)),//放大字号
        ],
      ),
    );

  }
}

// FittedBox缩放布局示例
class FittedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FittedBox缩放布局示例'),
      ),
      body: Container(
        color: Colors.grey,
        width: 250.0,
        height: 250.0,
        //缩放布局
        child: FittedBox(
          // 没有任何填充模式
//          fit: BoxFit.none,
          // 不按宽高比填充模式，内容不会超过容器范围
//          fit: BoxFit.fill,
          // 宽高等比填充，内容不会超过容器范围
          fit: BoxFit.contain,
          // 按原始尺寸填充整个容器，内容有可能会超过容器范围
//          fit: BoxFit.cover,
          // 按宽度填充，
//          fit: BoxFit.fitWidth,
          // 按高度填充
//          fit: BoxFit.fitHeight,
          // 根据情况缩小范围
//          fit: BoxFit.scaleDown,
          //对齐属性 左上角对齐 默认center
          alignment: Alignment.topLeft,
          //内部容器
          child: Container(
            color: Colors.deepOrange,
            child: Text("缩放布局"),
          ),
        ),
      ),
    );
  }
}

// Stack层叠布局示例
class StackAlignmentDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var stack = Stack(
      // 子组件左上角对齐
      alignment: Alignment.topLeft,
      children: <Widget>[
        // 底部添加一个头像
        CircleAvatar(
          backgroundImage: AssetImage('images/image4.png'),
          radius: 100.0,
        ),
        // 上面加一个容器 容器里再放一个文本
        Container(
          decoration: BoxDecoration(
            color: Colors.lightBlue,
          ),
          child: Text(
            'hello,flutter',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Stack层叠布局示例'),
      ),
      body: Center(
        child: stack,
      ),
    );
  }
}

// Stack层叠定位布局示例
class StackPositionedDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var stack = Stack(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('images/image5.png'),
            radius: 100.0,
          ),
          //设置定位布局
          Positioned(
              top: 50.0,
              right: 50.0,
              child: new Text(
                'hi flutter',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
        ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('层叠定位布局示例'),
      ),
      body: Center(
        //添加层叠布局
        child: stack,
      ),
    );
  }
}

// IndexedStack层叠布局示例
class IndexedStackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var stack = IndexedStack(

      index: 1, //设置索引为1就只显示文本内容了
      alignment: const FractionalOffset(0.2, 0.2),
      children: <Widget>[
        // 索引为0
        CircleAvatar(
          backgroundImage: new AssetImage('images/image5.png'),
          radius: 100.0,
        ),
        // 索引为1
        Container(
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
          child: Text(
            'hello flutter',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('IndexedStack层叠布局示例'),
      ),
      body: Center(
        child: stack,
      ),
    );
  }
}

// OverflowBox溢出父容器显示示例
class OverflowBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('OverflowBox溢出父容器显示示例'),
        ),
        body: Container(
          color: Colors.green,
          width: 200.0,
          height: 200.0,
          padding: const EdgeInsets.all(50.0),
          child: OverflowBox(
            alignment: Alignment.topLeft,
            maxWidth: 400.0,
            maxHeight: 400.0,
            child: Container(
              color: Colors.blueGrey,
              width: 300.0,
              height: 300.0,
            ),
          ),
        ));
  }
}

// SizedBox设置具体尺寸示例
class SizedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SizedBox设置具体尺寸示例'),
      ),
      body: SizedBox(
        // 固定宽为200.0 高为300.0
        width: 200.0,
        height: 300.0,
        child: const Card(
          child: Text('SizedBox',
            style: TextStyle(
              fontSize: 36.0,
            ),
          ),
        ),
      ),
    );
  }
}

// ConstrainedBox限定宽高示例
class ConstrainedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ConstrainedBox限定宽高示例'),
      ),
      // 添加容器
      body: ConstrainedBox(
        //设置限定值
        constraints: const BoxConstraints(
          minWidth: 150.0,
          minHeight: 150.0,
          maxWidth: 220.0,
          maxHeight: 220.0,
        ),
        // 子容器
        child: Container(
          width: 300.0,
          height: 300.0,
          color: Colors.green,
        ),
      ),
    );
  }
}

// LimitedBox限定宽高布局示例
class LimitedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LimitedBox限定宽高布局示例'),
        ),
        body: Row(
          children: <Widget>[
            Container(
              color: Colors.grey,
              width: 100.0,
            ),
            LimitedBox(
              maxWidth: 150.0,// 设置最大宽度 限定child在此范围内
              child: Container(
                color: Colors.lightGreen,
                width: 250.0,
              ),
            ),
          ],
        )
    );
  }
}

// AspectRatio调整宽高比示例
class AspectRatioDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AspectRatio调整宽高比示例'),
      ),
      body: Container(
        height: 200.0,
        child: AspectRatio(
          aspectRatio: 1.5,// 宽高比
          child: Container(
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}

// FractionallySizedBox百分比布局示例
class FractionallySizedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FractionallySizedBox示例'),
      ),
      body: Container(
        color: Colors.blue,
        height: 200.0,
        width: 200.0,
        child: FractionallySizedBox(
          alignment: Alignment.topLeft,// 元素左上角对齐
          widthFactor: 0.5,// 宽度因子
          heightFactor: 1.5,// 高度因子
          child: Container(
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}

// Transform矩阵转换示例
class TransformDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transform矩阵转换示例'),
      ),
      body: Center(
        // 父容器 作为背景
        child: Container(
          // 背景颜色
          color: Colors.grey,
          // 矩阵转换
          child:Transform(
            //对齐方式
            alignment: Alignment.topRight,
            // 设置旋转值
            transform: Matrix4.rotationZ(0.3),
            // 被旋转容器
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: const Color(0xFFE8581C),
              child: const Text('Transform矩阵转换'),
            ),
          ),
        ),
      ),
    );
  }
}

// Baseline基准线布局示例
class BaselineDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baseline基准线布局示例'),
      ),
      body: Row(
        // 水平等间距排列子组件
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //设置基准线
          Baseline(
            baseline: 80.0,
            // 对齐字符底部水平线
            baselineType: TextBaseline.alphabetic,
            child: Text(
              'AaBbCc',
              style: TextStyle(
                fontSize: 18.0,
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
          ),
          Baseline(
            baseline: 80.0,
            baselineType: TextBaseline.alphabetic,
            child: Container(
              width: 40.0,
              height: 40.0,
              color: Colors.green,
            ),
          ),
          Baseline(
            baseline: 80.0,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              'DdEeFf',
              style: TextStyle(
                fontSize: 26.0,
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Offstage控制是否显示组件示例
class OffstageDemo extends StatefulWidget {
  @override
  _OffstageDemo createState() => _OffstageDemo();
}

class _OffstageDemo extends State<OffstageDemo> {
  // 状态控制是否显示文本组件
  bool offstage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offstage控制是否显示组件示例"),
      ),
      body: Center(
        child: Offstage(
          offstage: offstage,// 控制是否显示
          child: Text(
            '我出来啦！',
            style: TextStyle(
              fontSize: 36.0,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //设置是否显示文本组件
          setState(() {
            offstage = !offstage;
          });
        },
        tooltip: "显示隐藏",
        child: Icon(Icons.flip),
      ),
    );
  }
}

// Wrap按宽高自动换行布局示例
class WrapDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wrap按宽高自动换行布局示例'),
      ),
      // 自动换行布局组件
      body: Wrap(
        spacing: 8.0, // Chip之间的间距大小
        runSpacing: 4.0, // 行之间的间距大小
        children: <Widget>[
          Chip(
            //添加圆形头像
            avatar: CircleAvatar(
                backgroundColor: Colors.lightGreen.shade800, child: Text('西门', style: TextStyle(fontSize: 10.0),)),
            label: Text('西门吹雪'),
          ),
          Chip(
            avatar: CircleAvatar(
                backgroundColor: Colors.lightBlue.shade700, child: Text('司空', style: TextStyle(fontSize: 10.0),)),
            label: Text('司空摘星'),
          ),
          Chip(
            avatar: CircleAvatar(
                backgroundColor: Colors.orange.shade800, child: Text('婉清', style: TextStyle(fontSize: 10.0),)),
            label: Text('木婉清'),
          ),
          Chip(
            avatar: CircleAvatar(
                backgroundColor: Colors.blue.shade900, child: Text('一郎', style: TextStyle(fontSize: 10.0),)),
            label: Text('萧十一郎'),
          ),
        ],
      ),
    );
  }
}

// 布局综合示例
class MixDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 地址部分
    Widget addressContainer = Container(
      padding: const EdgeInsets.all(32.0),//此部分四周间隔一定距离
      //水平布局
      child: Row(
        children: <Widget>[
          Expanded(
            //垂直布局
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 次轴即水平方向左侧对齐
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),// 与下面文本间隔一定距离
                  child: Text(
                    'flutter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'flutter社区',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          // 图标
          Icon(
            Icons.star,
            color: Colors.lightBlue[500],
          ),
          Text('66'),
        ],
      ),
    );

    // 构建按钮组中单个按钮 参数为图标及文本
    Column buildButtonColumn(IconData icon, String label) {
      // 垂直布局
      return Column(
        // 垂直方向大小最小化
        mainAxisSize: MainAxisSize.min,
        // 垂直方向居中对齐
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // 上面图标部分
          Icon(icon, color: Colors.lightBlue[600]),
          Container(
            // 距离上面图标一定间距
            margin: const EdgeInsets.only(top: 8.0),
            // 下面文本部分
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: Colors.lightBlue[600],
              ),
            ),
          )
        ],
      );
    }

    // 按钮组部分
    Widget buttonsContainer = Container(
      // 水平布局
      child: Row(
        // 水平方向均匀排列每个元素
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButtonColumn(Icons.call, '电话'),
          buildButtonColumn(Icons.near_me, '导航'),
          buildButtonColumn(Icons.share, '分享'),
        ],
      ),
    );

    // 文本部分
    Widget textContainer = Container(
      // 设置上下左右内边距
      padding: const EdgeInsets.all(32.0),
      // 文本块一定是用'''来引用起来
      child: Text(
        '''
        Flutter是一个由谷歌开发的开源移动应用软件开发工具包，用于为Android、iOS、 Windows、Mac、Linux、Google Fuchsia开发应用。
        Flutter第一个版本支持Android操作系统，开发代号称作“Sky”。 
        它于2015年4月的Flutter开发者会议上被公布，宣称其目标为实现120FPS的渲染性能。
        在上海Google Developer Days的主题演讲中，Google宣布了Flutter Release Preview 2，这是Flutter 1.0之前的最后一个重要版本。
        2018年12月4日，Flutter 1.0在Flutter Live活动中发布，是该框架的第一个“稳定”版本。
        2019年12月11日，在Flutter Interactive活动上发布了Flutter 1.12，宣布Flutter是第一个为环境计算设计的UI平台。。
        ''',
        softWrap: true,
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '布局综合示例',
            style: TextStyle(color: Colors.white),
          ),
        ),
        // 使用列表视图默认为垂直布局,并且子元素能够上下滚动
        body: ListView(
          children: <Widget>[
            FlutterLogo(
              size: 300,
              // 用于在徽标上绘制“Flutter”文本的颜色，
              textColor: Colors.blue,
              // 是否绘制“颤动”文本。默认情况下，仅绘制徽标本身
              duration: Duration(microseconds: 0),
              // 如果更改样式，颜色或 textColor属性，动画的时间长度
              style: FlutterLogoStyle.horizontal ,
              // 如果样式，颜色或textColor 发生更改，则会生成徽标动画的曲线。
              curve: Curves.bounceIn,
            ),
            addressContainer,
            buttonsContainer,
            textContainer,
          ],
        ),
    );
  }
}



