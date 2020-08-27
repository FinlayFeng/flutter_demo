import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chapter11 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      ChartsAnimation(),
      EasingAnimation(),
      FontAnimation(),
      HeroAnimation(),
      MaskAnimation(),
      OpacityAnimation(),
      ValueAnimation(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('动画示例'),
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

// 图表动画
class ChartsAnimation extends StatefulWidget {
  @override
  _ChartsAnimationState createState() => _ChartsAnimationState();
}

class _ChartsAnimationState extends State<ChartsAnimation> {
  // 定义图表高度
  var height = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图表动画'),
      ),
      body: Center(
        child: Container(
          height: 400,
          alignment: AlignmentDirectional.bottomStart,
          child: InkWell(
            onTap: () {
              //设置状态改变图表高度
              setState(() {
                height = 320;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //动画容器
                AnimatedContainer(
                  //动画时长
                  duration: Duration(seconds: 1),
                  //宽度不变
                  width: 40.0,
                  //当高度发生变化时 会有一个缓动效果
                  height: height - 40,
                  color: Colors.greenAccent,
                ),
                AnimatedContainer(
                  margin: EdgeInsets.only(left: 10.0),
                  duration: Duration(seconds: 2),
                  width: 40.0,
                  height: height - 10,
                  color: Colors.yellow,
                ),
                AnimatedContainer(
                  margin: EdgeInsets.only(left: 10.0),
                  duration: Duration(seconds: 3),
                  width: 40.0,
                  height: height - 60,
                  color: Colors.red,
                ),
                AnimatedContainer(
                  margin: EdgeInsets.only(left: 10.0),
                  duration: Duration(seconds: 2),
                  width: 40.0,
                  height: height - 50,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//缓动动画
class EasingAnimation extends StatefulWidget {
  @override
  _EasingAnimationState createState() => _EasingAnimationState();
}

class _EasingAnimationState extends State<EasingAnimation> with TickerProviderStateMixin {
  //动画控制器
  AnimationController _controller;
  //补间动画
  Animation _animation;

  @override
  void initState() {
    super.initState();
    //创建动画控制器 时长设置为2秒
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2),);
    //创建补间对象 值从-1.0到0.0进行估值
    _animation = Tween(begin: -1.0, end: 0.0).animate(
      //非线性动画
      CurvedAnimation(
        parent: _controller,
        //缓动动画 决定了运行的轨迹 快出慢进
        curve: Curves.fastOutSlowIn,
      ),
    )..addStatusListener(_handler);
  }

  //动画运行状态回调
  _handler(status) {
    //动画执行完成
    if (status == AnimationStatus.completed) {
      //移除状态监听
      _animation.removeStatusListener(_handler);
      //动画重置
      _controller.reset();
      //再次创建补间对象 值从0.0到1.0进行估值
      _animation = Tween(begin: 0.0, end: 1.0).animate(
        //缓动动画 决定了运行的轨迹
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      )..addStatusListener(
            (status) {
          //监听动画状态状态
          if (status == AnimationStatus.completed) {
            Navigator.pop(context);
          }
        },
      );
      //执行动画
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    //计算当前页面宽度
    final double width = MediaQuery.of(context).size.width;
    //执行动画
    _controller.forward();
    return Scaffold(
      appBar: AppBar(
        title: Text('缓动动画'),
      ),
      //动画构建器
      body: AnimatedBuilder(
        //动画控制器
        animation: _controller,
        //构建动画
        builder: (context, child) {
          //采用矩阵转换
          return Transform(
            //X方向值 = 当前动画值 * 宽度
            transform: Matrix4.translationValues(
              _animation.value * width,
              //Y = 0
              0.0,
              //Z = 0
              0.0,
            ),
            //移动的色块
            child: Center(
              child: Container(
                width: 200.0,
                height: 200.0,
                color: Colors.blue,
              ),
            ),
          );
        },
      ),
    );
  }

  //销毁动画
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

//字体放大动画
class FontAnimation extends StatefulWidget {
  _FontAnimation createState() => _FontAnimation();
}

//TickerProvider提供动画驱动
class _FontAnimation extends State<FontAnimation> with SingleTickerProviderStateMixin {
  //补间动画
  Animation<double> tween;
  //动画控制对象
  AnimationController controller;
  /*初始化状态*/
  initState() {
    super.initState();
    /**
     * 创建动画控制类对象
     * duration:动画执行的时间 单位是毫秒
     * vsync:防止动画离屏之后继续消耗资源
     */
    controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    /*创建补间对象*/
    tween = Tween(begin: 0.0, end: 1.0)
        .animate(controller)//返回Animation对象
      ..addListener((){//添加监听
        setState((){
          print(tween.value);//打印补间插值
        });
      });
    controller.forward();//执行动画
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter动画',
        ),
      ),
      //添加手势组件
      body: GestureDetector(
          onTap:(){
            //点击文本重新执行动画
            startAnimation();
          },
          child: Center(
              child: Text(
                "字体放大",
                //根据动画执行过程中产生的value 更改文本字体大小
                style: TextStyle(fontSize: 60 * controller.value),
              )
          )
      ),
    );
  }
  //重新开始执行动画
  startAnimation() {
    setState(() {
      //从起始值执行动画
      controller.forward(from: 0.0);
    });
  }
  //销毁动画
  dispose() {
    //销毁控制器对象
    controller.dispose();
    super.dispose();
  }
}

//页面切换动画
class HeroAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("页面切换动画图一"),
      ),
      //点击切换
      body: GestureDetector(
        //添加动画组件
        child: Hero(
          tag: '第一张图片',
          child: Image.asset(
            "images/image1.png",
            fit: BoxFit.fill,
          )
        ),
        onTap: (){
          //路由至第第二个页面
          Navigator.push(context, MaterialPageRoute(builder: (_){
            return DestinationPage();
          }));
        },
      ),
    );
  }
}

//第二个页面即目标页面
class DestinationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("页面切换动画图二"),
      ),
      //点击返回
      body: GestureDetector(
        //添加动画组件
        child: Hero(
          tag: "第二张图片",
          child: Image.asset(
            "images/image2.png",
            fit: BoxFit.fill,
          )),
        onTap: (){
          //页面返回
          Navigator.pop(context);
        },
      ),
    );
  }
}

//遮罩动画
class MaskAnimation extends StatefulWidget {
  @override
  _MaskAnimationState createState() => _MaskAnimationState();
}

class _MaskAnimationState extends State<MaskAnimation> with TickerProviderStateMixin {
  //动画控制器
  AnimationController _controller;
  //容器宽高值补间对象
  Animation<double> transitionTween;
  //容器边框弧度补间对象
  Animation<BorderRadius> borderRadius;

  @override
  void initState() {
    super.initState();
    //构造动画控制器对象 动画时长2秒
    _controller = AnimationController(duration: const Duration(seconds: 10), vsync: this)
      ..addStatusListener((status) {
        //动画执行完返回上一页面
        if (status == AnimationStatus.completed) {
          Navigator.pop(context);
        }
      });

    //创建补间对象 控制容器宽高 变化范围从50.0到200.0
    transitionTween = Tween<double>(
      begin: 50.0,
      end: 200.0,
    ).animate(
      //设置非线性动画
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    //创建补间对象 控制容器边框弧度 变化范围从75.0到0.0
    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(75.0),
      end: BorderRadius.circular(0.0),
    ).animate(
      //设置非线性动画
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    //执行动画
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //动画构建器
    return AnimatedBuilder(
      //动画控制器
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('遮罩动画'),
          ),
          //居中展示
          body: Center(
            //使用层叠组件 提供上下两个容器
            child: Stack(
              children: <Widget>[
                Center(
                  //下层容器始终不变 为上层容器变化提供视觉参照
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    color: Colors.blue,
                  ),
                ),
                Center(
                  //上层容器根据补间对象改变属性值进行形变
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    //根据补间对象值改变宽高
                    width: transitionTween.value,
                    height: transitionTween.value,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      //根据BorderRadiusTween补间对象改为边框弧度
                      borderRadius: borderRadius.value,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//淡入淡出动画
class OpacityAnimation extends StatefulWidget {
  @override
  _OpacityAnimationState createState() => _OpacityAnimationState();
}

class _OpacityAnimationState extends State<OpacityAnimation> {
  //控制动画显示状态变量
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('淡入淡出动画'),
      ),
      body: Center(
        //添加Opacity动画
        child: AnimatedOpacity(
          //控制opacity值 范围从0.0到1.0
          opacity: _visible ? 1.0 : 0.0,
          //设置动画时长
          duration: Duration(
              milliseconds: 1000
          ),
          child: Container(
            width: 300.0,
            height: 300.0,
            color: Colors.greenAccent,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //控制动画显示状态
          setState(() {
            _visible = !_visible;
          });
        },
        tooltip: "显示隐藏",
        child: Icon(Icons.flip),
      ),
    );
  }
}

//数字变化动画
class ValueAnimation extends StatefulWidget {
  @override
  _ValueAnimationState createState() => _ValueAnimationState();
}

class _ValueAnimationState extends State<ValueAnimation> with TickerProviderStateMixin {
  //动画控制器
  AnimationController controller;
  //补间对象
  Animation animation;

  @override
  void initState() {
    super.initState();
    //创建动画控制器 时长设置为1秒
    controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    //创建非线性动画 让数字在切换时有一种动感
    final Animation curve = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    //创建整型补间对象 产生从0到10的数字
    animation = IntTween(begin: 0, end: 10).animate(curve)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //当动画执行完成后 执行反转动画 如0...10 然后是10...0
        controller.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
              appBar: AppBar(
                title: Text('数字变化动画'),
              ),
              body: Center(
                //根据补间对象产生的数字显示
                child: Text(animation.value.toString(), style: TextStyle(fontSize: 48.0)),
              ));
        });
  }
  //销毁动画
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

