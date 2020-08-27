import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chapter10 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      OpacityDemo(),
      DecoratedBoxDemo(),
      RotatedBoxDemo(),
      ClipDemo(),
      CustomPaintDemo(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('组件装饰和视觉效果'),
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

class OpacityDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opacity不透明度示例'),
      ),
      body: Center(
        child: Opacity(
          opacity: 0.3, //不透明度设置为0.3
          child: Container(
            width: 250.0,
            height: 100.0,
            //添加装饰器
            decoration: BoxDecoration(
              color: Colors.black, //背景色设置为纯黑
            ),
            child: Text(
              '不透明度为0.3',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DecoratedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DecoratedBox示例'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Text('DecoratedBox背景示例'),
          Container(
            width: 100.0,
            height: 100.0,
            //装饰器
            decoration: BoxDecoration(
              //背景色
              color: Colors.grey,
              //图片装饰器
              image: DecorationImage(
                image: ExactAssetImage('images/image1.png'), //添加image属性
                fit: BoxFit.cover, //填充类型
              ),
            ),
          ),
          Text('BoxDecoration边框圆角示例'),
          Container(
            width: 100.0,
            height: 100.0,
            //装饰器
            decoration: BoxDecoration(
              //背景色
              color: Colors.white,
              //添加所有的边框,颜色为灰色，宽度为4.0
              border: Border.all(color: Colors.blue, width: 4.0),
              //添加边框弧度，这样会有一个圆角效果
              borderRadius: BorderRadius.circular(36.0),
              //添加背景图片
              image: DecorationImage(
                image: ExactAssetImage('images/image2.png'), //添加image属性
                fit: BoxFit.cover, //填充类型
              ),
            ),
          ),
          Text('BoxDecoration边框阴影示例'),
          Container(
            width: 200.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.white,
              //边框阴影效果 可添加多个BoxShadow 是一种组合效果
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey, //阴影颜色
                  blurRadius: 8.0, //模糊值
                  spreadRadius: 8.0, //扩展阴影半径
                  offset: Offset(-1.0, 1.0), //x/y方向偏移量
                ),
              ],
            ),
            child: Text(
              'BoxShadow阴影效果',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
              ),
            ),
          ),
          Text('LinearGradient线性渐变效果'),
          DecoratedBox(
            decoration: BoxDecoration(
              //线性渐变
              gradient: LinearGradient(
                begin: const FractionalOffset(0.5, 0.0), //起始偏移量
                end: const FractionalOffset(1.0, 1.0), //终止偏移量
                //渐变颜色数据集
                colors: <Color>[
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.grey,
                ],
              ),
            ),
            child: Container(
              width: 200.0,
              height: 100.0,
              child: Center(
                child: Text(
                  'LinearGradient线性渐变效果',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                  ),
                ),
              ),
            ),
          ),
          Text('RadialGradient环形渐变效果'),
          DecoratedBox(
            decoration: BoxDecoration(
              //环形渐变
              gradient: RadialGradient(
                //中心点偏移量,x和y均为0.0表示在正中心位置
                center: const Alignment(-0.0, -0.0),
                //圆形半径
                radius: 0.50,
                //渐变颜色数据集
                colors: <Color>[
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.grey,
                ],
              ),
            ),
            child: Container(
              width: 200.0,
              height: 100.0,
              child: new Center(
                child: Text(
                  'RadialGradient环形渐变效果',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class RotatedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RotatedBox旋转盒子示例',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: RotatedBox(
          quarterTurns: 3, //旋转次数，一次为90度
          child: Text(
            'RotatedBox旋转盒子',
            style: TextStyle(fontSize: 28.0),
          ),
        ),
      ),
    );
  }
}

class ClipDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clip示例',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
          //圆形剪裁
          child: Column(
        children: <Widget>[
          ClipOval(
            //固定大小
            child: SizedBox(
              width: 100.0,
              height: 100.0,
              //添加图片
              child: Image.asset(
                "images/image1.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(
                //圆角弧度，值越大弧度越大
                Radius.circular(30.0)),
            //固定大小
            child: SizedBox(
              width: 100.0,
              height: 100.0,
              child: Image.asset(
                "images/image2.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          ClipRect(
            //指定自定义Clipper
            clipper: RectClipper(),
            child: SizedBox(
              width: 100.0,
              height: 100.0,
              child: Image.asset(
                "images/image3.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          ClipPath(
            clipper: TriangleClip(), //指定自定义三角形Clipper
            child: SizedBox(
              width: 100.0,
              height: 100.0,
              child: Image.asset(
                "images/image4.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      )),
    );
  }
}

// 自定义Clipper,类型为Rect
class RectClipper extends CustomClipper<Rect> {
  // 重写获取剪裁范围
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(100.0, 100.0, size.width - 50.0, size.height - 50.0);
  }

  // 重写是否重新剪裁
  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

// 自定义三角形Clipper,类型为Path
class TriangleClip extends CustomClipper<Path> {
  // 重写获取剪裁范围
  @override
  Path getClip(Size size) {
    Path path = Path();
    //移动至起始点(50.0,50.0)
    path.moveTo(50.0, 50.0);
    //开始画线 起始点(50.0,50.0) 终止点(50.0,10.0)
    path.lineTo(50.0, 10.0);
    //开始画线 起始点(50.0,10.0) 终止点(100.0,50.0)
    path.lineTo(100.0, 50.0);
    path.close(); //使这些点构成三角形
    return path;
  }

  //重写是否重新剪裁
  @override
  bool shouldReclip(TriangleClip oldClip) {
    return true;
  }
}

class CustomPaintDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CustomPaint示例",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.only(top: 20.0),
            child: CustomPaint(
              painter: LinePainter1(),
              child: Center(
                child: Text(
                  '绘制直线',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.only(top: 20.0),
            child: CustomPaint(
              painter: LinePainter2(),
              child: Center(
                child: Text(
                  '绘制圆',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.only(top: 20.0),
            child: CustomPaint(
              painter: LinePainter3(),
              child: Center(
                child: Text(
                  '绘制椭圆',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.only(top: 20.0),
            child: CustomPaint(
              painter: LinePainter4(),
              child: Center(
                child: Text(
                  '绘制圆角矩形',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.only(top: 60.0),
            child: CustomPaint(
              painter: LinePainter5(),
              child: Center(
                child: Text(
                  '绘制嵌套矩形',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 400.0,
            height: 400.0,
            margin: EdgeInsets.only(top: 40.0),
            child: CustomPaint(
              painter: LinePainter6(),
              child: Center(
                child: Text(
                  '绘制多个点',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 200.0,
            height: 200.0,
            margin: EdgeInsets.only(top: 40.0),
            child: CustomPaint(
              painter: LinePainter7(),
              child: Center(
                child: Text(
                  '绘制圆弧',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 400.0,
            height: 400.0,
            margin: EdgeInsets.only(top: 40.0),
            child: CustomPaint(
              painter: LinePainter8(),
              child: Center(
                child: Text(
                  '绘制路径Path',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//继承于CustomPainter并且实现CustomPainter里面的paint和shouldRepaint方法
class LinePainter1 extends CustomPainter {
  //定义画笔
  Paint _paint = Paint()
    ..color = Colors.black
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = true
    ..strokeWidth = 3.0
    ..style = PaintingStyle.stroke;

  //重写绘制内容方法
  @override
  void paint(Canvas canvas, Size size) {
    //绘制直线
    canvas.drawLine(Offset(50.0, 20.0), Offset(350.0, 20.0), _paint);
  }

  //重写是否需要重绘的
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

//继承于CustomPainter并且实现CustomPainter里面的paint和shouldRepaint方法
class LinePainter2 extends CustomPainter {
  //定义画笔
  Paint _paint = Paint()
    ..color = Colors.grey
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = true
    ..strokeWidth = 3.0
    ..style = PaintingStyle
        .stroke; //画笔样式有填充PaintingStyle.fill及没有填充PaintingStyle.stroke两种

  //重写绘制内容方法
  @override
  void paint(Canvas canvas, Size size) {
    //绘制圆 参数为中心点，半径，画笔
    canvas.drawCircle(Offset(210.0, 60.0), 50.0, _paint);
  }

  //重写是否需要重绘的
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

//继承于CustomPainter并且实现CustomPainter里面的paint和shouldRepaint方法
class LinePainter3 extends CustomPainter {
  //定义画笔
  Paint _paint = Paint()
    ..color = Colors.grey
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = true
    ..strokeWidth = 3.0
    ..style = PaintingStyle
        .fill; //画笔样式有填充PaintingStyle.fill及没有填充PaintingStyle.stroke两种

  ///重写绘制内容方法
  @override
  void paint(Canvas canvas, Size size) {
    //绘制椭圆
    //使用一个矩形来确定绘制的范围,椭圆是在这个矩形之中内切的,第一个参数为左上角坐标,第二个参数为右下角坐标
    Rect rect = Rect.fromPoints(Offset(50.0, 10.0), Offset(350.0, 100.0));
    canvas.drawOval(rect, _paint);
  }

  ///重写是否需要重绘的
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

//继承于CustomPainter并且实现CustomPainter里面的paint和shouldRepaint方法
class LinePainter4 extends CustomPainter {
  //定义画笔
  Paint _paint = Paint()
    ..color = Colors.grey
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = true
    ..strokeWidth = 3.0
    ..style = PaintingStyle
        .stroke; //画笔样式有填充PaintingStyle.fill及没有填充PaintingStyle.stroke两种

  ///重写绘制内容方法
  @override
  void paint(Canvas canvas, Size size) {
    //中心点坐标为200,50 边长为60
    Rect rect = Rect.fromCircle(center: Offset(200.0, 50.0), radius: 60.0);
    //根据矩形创建一个角度为10的圆角矩形
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(20.0));
    //开始绘制圆角矩形
    canvas.drawRRect(rrect, _paint);
  }

  ///是否需要重绘
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

//继承于CustomPainter并且实现CustomPainter里面的paint和shouldRepaint方法
class LinePainter5 extends CustomPainter {
  //定义画笔
  Paint _paint = Paint()
    ..color = Colors.grey
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = true
    ..strokeWidth = 3.0
    ..style = PaintingStyle
        .stroke; //画笔样式有填充PaintingStyle.fill及没有填充PaintingStyle.stroke两种

  ///重写绘制内容方法
  @override
  void paint(Canvas canvas, Size size) {
    //初始化两个矩形
    Rect rect1 = Rect.fromCircle(center: Offset(200.0, 50.0), radius: 80.0);
    Rect rect2 = Rect.fromCircle(center: Offset(200.0, 50.0), radius: 40.0);
    //再把这两个矩形转化成圆角矩形
    RRect outer = RRect.fromRectAndRadius(rect1, Radius.circular(20.0));
    RRect inner = RRect.fromRectAndRadius(rect2, Radius.circular(10.0));
    canvas.drawDRRect(outer, inner, _paint);
  }

  //是否需要重绘
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

//继承于CustomPainter并且实现CustomPainter里面的paint和shouldRepaint方法
class LinePainter6 extends CustomPainter {
  //定义画笔
  Paint _paint = Paint()
    ..color = Colors.blue
    ..strokeCap = StrokeCap.round //StrokeCap.round为圆点 StrokeCap.square为方形
    ..isAntiAlias = true
    ..strokeWidth = 20.0 //画笔粗细 值调大点 这样点看起来明显一些
    ..style = PaintingStyle.fill; //用于绘制点时PaintingStyle值无效

  //重写绘制内容方法
  @override
  void paint(Canvas canvas, Size size) {
    //绘制点
    canvas.drawPoints(

        //PointMode的枚举类型有三个，points点，lines隔点连接线，polygon相邻连接线
        PointMode.points,
        [
          Offset(50.0, 60.0),
          Offset(40.0, 90.0),
          Offset(100.0, 100.0),
          Offset(300.0, 350.0),
          Offset(400.0, 80.0),
          Offset(200.0, 200.0),
        ],
        _paint..color = Colors.grey);
  }

  //是否需要重绘
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

//继承于CustomPainter并且实现CustomPainter里面的paint和shouldRepaint方法
class LinePainter7 extends CustomPainter {
  //定义画笔
  Paint _paint = Paint()
    ..color = Colors.grey
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 2.0 //画笔粗细
    ..style = PaintingStyle.stroke; //用于绘制点时PaintingStyle值无效

  //重写绘制内容方法
  @override
  void paint(Canvas canvas, Size size) {
    //绘制圆弧
    const PI = 3.1415926;
    //定义矩形
    Rect rect1 = Rect.fromCircle(center: Offset(100.0, 0.0), radius: 100.0);
    //画1/2PI弧度的圆弧
    canvas.drawArc(rect1, 0.0, PI / 2, true, _paint);
    //画PI弧度的圆弧
    Rect rect2 = Rect.fromCircle(center: Offset(200.0, 150.0), radius: 100.0);
    canvas.drawArc(rect2, 0.0, PI, true, _paint);
  }

  //是否需要重绘
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

//继承于CustomPainter并且实现CustomPainter里面的paint和shouldRepaint方法
class LinePainter8 extends CustomPainter {
  //定义画笔
  Paint _paint = Paint()
    ..color = Colors.grey
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 2.0 //画笔粗细
    ..style = PaintingStyle.stroke; //用于绘制点时PaintingStyle值无效

  //重写绘制内容方法
  @override
  void paint(Canvas canvas, Size size) {
    //新建一个path移动到一个位置，然后画各种线
    Path path = Path()..moveTo(100.0, 100.0);
    path.lineTo(200.0, 300.0);
    path.lineTo(100.0, 200.0);
    path.lineTo(150.0, 250.0);
    path.lineTo(150.0, 400.0);
    canvas.drawPath(path, _paint);
  }

  //是否需要重绘
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
