import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => Myself(),
      "/personalInfo": (context) => PersonalInfo(),
      "/historyOrder": (context) => HistoryOrder(),
      "/wallet": (context) => Wallet(),
    },
  ));
}

class Myself extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Myself"),
      ),
      backgroundColor: Color(0xfff7c341),
      body: _listView(context),
    );
  }

  ListView _listView(BuildContext context) {
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      //padding: EdgeInsets.all(15),
      children: [
        _normalCard(),
        // Row(
        //   children: <Widget>[
        //     // CircleAvatar(
        //     //   // 宽高不一致为，裁剪后为椭圆形
        //     //   child: Container(
        //     //     height: 100,
        //     //     width: 150,
        //     //     child: Image.asset(
        //     //       "images/login/login_logo.png",
        //     //       fit: BoxFit.cover,
        //     //     ),
        //     //   ),
        //     // ),
        //
        //     Container(
        //         width: 100,
        //         height: 100,
        //         decoration: ShapeDecoration(
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(16)),
        //             image: DecorationImage(
        //                 fit: BoxFit.cover,
        //                 image: AssetImage("images/login/login_logo.png")))),
        //     Text("用户昵称"),
        //   ],
        // ),

        // Image(
        //
        //   fit: BoxFit.cover,
        //   image: new AssetImage('images/login/login_logo.png'),
        // ),
        //Padding(padding: EdgeInsets.all(10)),
        _shapeCard(context, "个人信息", "/personalInfo"),
        _shapeCard0(context, "历史订单", "/historyOrder"),
        //_shapeCard(context,"钱包","/wallet")
      ],
    );
  }

  Card _normalCard() {
    return Card(
      color: Colors.white, // 背景色
      // shadowColor: Colors.white, // 阴影颜色
      // elevation: 20, // 阴影高度
      //borderOnForeground: false, // 是否在 child 前绘制 border，默认为 true
      margin: EdgeInsets.fromLTRB(0, 50, 0, 30), // 外边距

      //Text("Noraml Card", style: TextStyle(color: Colors.white),),

      child: Container(
          width: 300,
          height: 100,
          // alignment: Alignment.center,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              // textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                // CircleAvatar(
                //   // 宽高不一致为，裁剪后为椭圆形
                //   child: Container(
                //     height: 100,
                //     width: 150,
                //     child: Image.asset(
                //       "images/login/login_logo.png",
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

                Container(
                    width: 100,
                    height: 100,
                    child: Image.asset("images/login/login_logo.png")),
                Text("用户昵称"),
              ])),
    );
  }

  Card _shapeCard(BuildContext context, String str, String route) {
    return Card(
      color: Colors.white, // 背景色
      // shadowColor: Colors.white, // 阴影颜色
      // elevation: 20, // 阴影高度
      borderOnForeground: false, // 是否在 child 前绘制 border，默认为 true
      //margin: EdgeInsets.fromLTRB(0, 50, 0, 30), // 外边距

      // 边框
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(
          color: Colors.white,
          width: 3,
        ),
      ),

      child: Container(
          width: 300,
          height: 250,
          alignment: Alignment.center,
          //child: Text(str, style: TextStyle(color: Colors.white),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.account_box,
                    size: 32.0,
                  ),
                  Text("zzh")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.home,
                    size: 32.0,
                  ),
                  Text("地址")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.phone,
                    size: 32.0,
                  ),
                  Text("电话")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, route);
                    },
                    icon: Icon(
                      Icons.star,
                      size: 32.0,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Card _shapeCard0(BuildContext context, String str, String route) {
    return Card(
      color: Colors.white, // 背景色
      // shadowColor: Colors.white, // 阴影颜色
      // elevation: 20, // 阴影高度
      borderOnForeground: false, // 是否在 child 前绘制 border，默认为 true
      //margin: EdgeInsets.fromLTRB(0, 50, 0, 30), // 外边距

      // 边框
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(
          color: Colors.white,
          width: 3,
        ),
      ),

      child: Container(
          width: 300,
          height: 130,
          alignment: Alignment.center,
          //child: Text(str, style: TextStyle(color: Colors.white),),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Badge(
                //文本内容Text为空时子组件为null时则返回一个红点，其他值时按实际显示
                badgeContent: Text(""),
                child: Container(
                    height: 80,
                    width: 40,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, route);
                          },
                          icon: Icon(
                            Icons.local_grocery_store_outlined,
                            size: 32.0,
                          ),
                        ),
                        Text(
                          "待配送",
                          style: new TextStyle(
                            fontFamily: "Ewert",
                            fontSize: 12,
                          ),
                          softWrap: false,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
                //子组件
                badgeColor: Colors.red,
                //右上角小红点颜色（默认时为红色）
                showBadge: true,
                //true时刷新时会在右则摆动一下
                animationDuration: Duration(seconds: 10),
                //小点点在右侧摆动的时间,这里为10秒
                toAnimate: true, //允许摆动，false时showBadge会失效
              ),

              // Badge(
              //   //文本内容Text为空时子组件为null时则返回一个红点，其他值时按实际显示
              //   badgeContent:Text(""),
              //   child: Text("待收货"), //子组件
              //   badgeColor: Colors.red,  //右上角小红点颜色（默认时为红色）
              //   showBadge: true,//true时刷新时会在右则摆动一下
              //   animationDuration:Duration(seconds: 10),//小点点在右侧摆动的时间,这里为10秒
              //   toAnimate:true, //允许摆动，false时showBadge会失效
              //
              // ),
              Badge(
                //文本内容Text为空时子组件为null时则返回一个红点，其他值时按实际显示
                badgeContent: Text(""),
                child: Container(
                    height: 80,
                    width: 40,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, route);
                          },
                          icon: Icon(
                            Icons.people,
                            size: 32.0,
                          ),
                        ),
                        Text(
                          "待收货",
                          style: new TextStyle(
                            fontFamily: "Ewert",
                            fontSize: 12,
                          ),
                          softWrap: false,
                        )
                      ],
                    )),
                //子组件
                badgeColor: Colors.red,
                //右上角小红点颜色（默认时为红色）
                showBadge: true,
                //true时刷新时会在右则摆动一下
                animationDuration: Duration(seconds: 10),
                //小点点在右侧摆动的时间,这里为10秒
                toAnimate: true, //允许摆动，false时showBadge会失效
              ),
              Badge(
                //文本内容Text为空时子组件为null时则返回一个红点，其他值时按实际显示
                badgeContent: Text(""),
                child: Container(
                    height: 80,
                    width: 40,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, route);
                          },
                          icon: Icon(
                            Icons.star,
                            size: 32.0,
                          ),
                        ),
                        Text(
                          "收藏",
                          style: new TextStyle(
                            fontFamily: "Ewert",
                            fontSize: 12,
                          ),
                          softWrap: false,
                        ),
                      ],
                    )),
                //子组件
                badgeColor: Colors.red,
                //右上角小红点颜色（默认时为红色）
                showBadge: true,
                //true时刷新时会在右则摆动一下
                animationDuration: Duration(seconds: 10),
                //小点点在右侧摆动的时间,这里为10秒
                toAnimate: true, //允许摆动，false时showBadge会失效
              ),
              // Badge(
              //   //文本内容Text为空时子组件为null时则返回一个红点，其他值时按实际显示
              //   badgeContent:Text(""),
              //   child: Text("待配送"), //子组件
              //   badgeColor: Colors.red,  //右上角小红点颜色（默认时为红色）
              //   showBadge: true,//true时刷新时会在右则摆动一下
              //   animationDuration:Duration(seconds: 10),//小点点在右侧摆动的时间,这里为10秒
              //   toAnimate:true, //允许摆动，false时showBadge会失效
              //
              // ),
            ],
          )),
    );
  }
}

class PersonalInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("个人信息"),
        ),
        body: new Column(
          children: <Widget>[
            ListBody(
              mainAxis: Axis.vertical,
              reverse: false,
              children: <Widget>[
                Container(
                    height: 50,
                    width: 50,
                    color: Colors.black12,
                    child: Column(children: <Widget>[
                      Text("AAA"),
                      Divider(
                        //分割线高度
                        thickness: 5,
                      ),
                    ])),
                // Divider(
                //   //分割线高度
                //   thickness: 5,
                // ),
                Container(
                    height: 50,
                    width: 50,
                    color: Colors.black12,
                    child: Column(children: <Widget>[
                      Text("AAA"),
                      Divider(
                        //分割线高度
                        thickness: 5,
                      ),
                    ])),
                Container(
                  height: 50,
                  width: 50,
                  color: Colors.black12,
                  child: Text("AAA"),
                )
              ],
            ),
          ],
        ));
  }
}

class Wallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("跳回首页"),
          onPressed: () {
            Navigator.pushNamed(context, "/");
//            Navigator.push(context, MaterialPageRoute(builder: (context) {
//              return SecondScreen();
//            }));
          },
        ),
      ),
    );
  }
}
// // //
// // //
// // //
// import 'package:flutter/material.dart';
//

// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(new ExpansionPanelPage());
// }

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

// var map = {{"2021/11/12": "DeliverA"},
//   "2021/12/01": "DeliverB",
//   "2021/12/01": "DeliverC",};

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: "name $index",
      expandedValue: 'This is item number $index',
    );
  });
}

class HistoryOrder extends StatefulWidget {
  HistoryOrder({Key? key}) : super(key: key);

  @override
  _ExpansionPanelPageState createState() => _ExpansionPanelPageState();
}

class _ExpansionPanelPageState extends State<HistoryOrder> {
  List<Item> _data = generateItems(20);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('HistoryOrder'),
        leading: new IconButton(
          //这是图标长按会出现的提示信息，返回按钮这么常用，应该不需要吧
          //tooltip: '返回上一页',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, "/");
//            Navigator.push(context, MaterialPageRoute(builder: (context) {
//              return SecondScreen();
//            }));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _buildPanel(),
        ),
      ),
    ));
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle: Text('To delete this panel, tap the trash can icon'),
              trailing: Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:badges/badges.dart';
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     String a = "1";
//     bool flag = true;
//     if (a == "") {
//       flag = false;
//     }
//     return MaterialApp(
//       title: 'Flutter',
//       home: Scaffold(
//         body: Center(
//           //小红点组件
//           // child: Badge.before(
//           //     value: "Text", // value to show inside the badge
//           //     child: new Text("button") // text to append (required)
//           // )
//           child:Badge(
//             //文本内容Text为空时子组件为null时则返回一个红点，其他值时按实际显示
//             badgeContent:Text(""),
//             child: Text("aaa"), //子组件
//             badgeColor: Colors.red,  //右上角小红点颜色（默认时为红色）
//             showBadge: flag,//true时刷新时会在右则摆动一下
//             animationDuration:Duration(seconds: 10),//小点点在右侧摆动的时间,这里为10秒
//             toAnimate:true, //允许摆动，false时showBadge会失效
//
//           ),
//         ),
//       ),
//     );
//   }
// }
