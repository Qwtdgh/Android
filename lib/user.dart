part of main;

class _UserPage extends StatelessWidget {
  late int userID;

  _UserPage(int userID) {
    this.userID = userID;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Myself(this.userID),
        "/personalInfo": (context) => PersonalInfo(),
        "/sendOrder": (context, {arguments}) => _Order_SendRoute(),
        "/receiveOrder": (context, {arguments}) => _Order_ReceiveRoute(),
        "/wallet": (context) => Wallet(),
      },
    );
  }
}

class MyselfListState extends State<MyselfList> {
  late int userID = -1;
  late String userNickname = "";
  late String userAddress = "";
  late String userTel = "";
  late List sendOrders = [];
  late List receiveOrders = [];

  MyselfListState(int userID) {
    this.userID = userID;
  }

  getAll(BuildContext context) async {
    // CustomSnackBar(context, const Text('Login button pressed'));

    var baseUrl = "http://delivery.mcatk.com";
    var uri = "/api/getInformation/";
    var body = {"userID": this.userID.toString()};
    http.Response response = await http.post(Uri.parse(baseUrl + uri), body: Convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    var result = Convert.jsonDecode(responseBody);
    print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');

    //var http =  HttpRequest("http://delivery.mcatk.com");

    //Map<String, String> ret = http.post("/api/login/", body) as Map<String, String>;
    //String? userID = ret["userID"];
    var userID = result["userID"];
    print(userID);
    setState(() {
      this.userNickname = result["userNickName"];
      this.userAddress = result["userAddress"];
      this.userTel = result["userTel"];
      this.receiveOrders = result["userOrders"];
      this.sendOrders = result["userDeliveryOrders"];
    });
    // Navigator.pushNamed(context, "/main", arguments: userID);
  }

  @override
  Widget build(BuildContext context) {

    getAll(context);

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
                  Text('${this.userNickname}'),
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
                    Text('${this.userNickname}')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      size: 32.0,
                    ),
                    Text('${this.userAddress}')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      size: 32.0,
                    ),
                    Text('${this.userTel}')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        //修改信息部分
                        //需要调用修改信息的函数
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
                              Navigator.pushNamed(context, "/sendOrder", arguments: 1);
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
                              Navigator.pushNamed(context, "/receiveOrder");
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
                              Navigator.pushNamed(context, "/receiveOrder");
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
              ],
            )),
      );
    }

    return ListView(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      //padding: EdgeInsets.all(15),
      children: [
        _normalCard(),
        _shapeCard(context, "个人信息", "/personalInfo"),
        _shapeCard0(context, "历史订单", "/sendOrder"),
        //_shapeCard(context,"钱包","/wallet")
      ],
    );
  }
}

class MyselfList extends StatefulWidget {
  late int userID = -1;

  MyselfList(int userID) {
    this.userID = userID;
}

  @override
  createState() => MyselfListState(this.userID);
}

class Myself extends StatelessWidget {
  late int userID;

  Myself(int userID) {
    this.userID = userID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Myself"),
      ),
      backgroundColor: Color(0xfff7c341),
      body: MyselfList(this.userID),
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

// class HistoryOrder extends StatefulWidget {
//   HistoryOrder({Key? key}) : super(key: key);
//
//   @override
//   _ExpansionPanelPageState createState() => _ExpansionPanelPageState();
// }

class MyList extends StatefulWidget {


  @override
  createState() => MyListState();
}

class MyListState extends State<MyList> {


  List<Map<String, String>> sends = [
    {"id": "1", "d": "kk", "rp": "receiver", "time": "11/31"},
    {"id": "2", "d": "kk", "rp": "receiver", "time": "11/31"},
    {"id": "3", "d": "kk", "rp": "receiver", "time": "11/31"},
    {"id": "4", "d": "kk", "rp": "receiver", "time": "11/31"},
    {"id": "5", "d": "kk", "rp": "receiver", "time": "11/31"},
    {"id": "6", "d": "kk", "rp": "receiver", "time": "11/31"},
    {"id": "7", "d": "kk", "rp": "receiver", "time": "11/31"},
    {"id": "8", "d": "kk", "rp": "receiver", "time": "11/31"},
    {"id": "9", "d": "kk", "rp": "receiver", "time": "11/31"},
    {"id": "10", "d": "kk", "rp": "receiver", "time": "11/31"},
    {"id": "11", "d": "kk", "rp": "receiver", "time": "11/31"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: sends.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 150,
            decoration: BoxDecoration(
                //border: new Border.all(color: Color(0xFF3E3737), width: 2),
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular((10.0))),
            margin: const EdgeInsets.only(left: 0.0, right: 0.0, top: 5.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '订单号：${sends[index]["id"]}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${sends[index]["time"]}',
                              style: const TextStyle(),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
                const Divider(
                  thickness: 1.0,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '收货人：${sends[index]["rp"]}',
                              style: const TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '目的地：${sends[index]["d"]}',
                              style: const TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 10.0, top: 20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.red,
                            fixedSize: const Size.fromHeight(10)),
                        child: const Text(
                          '已送达',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        onPressed: () {
                          setState(() {
                            sends.removeAt(index);
                          });
                        },
                      ),
                    ))
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class _Order_SendRoute extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // final List<int> colorCodes = <int>[600, 500, 100];

    return Scaffold(
      appBar: AppBar(
        title: const Text('送餐'),
        shadowColor: Colors.yellow,
      ),
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: MyList(),
    );
  }
}

class ExpansionList extends StatefulWidget {


  late List receiveOrders = [];
  
  ExpansionList(List receiveOrders) {
    this.receiveOrders = receiveOrders;  
  }
  
  @override
  State createState() {
    return ExpansionListState(this.receiveOrders);
  }
}

class ExpansionListState extends State<ExpansionList> {

  
  late List receiveOrders = [];
  
  ExpansionListState(List receiveOrders) {
    this.receiveOrders = receiveOrders;


  }

  // final List<Map<String, String>> receiveOrders = [
  //   {
  //     "time": "11-30",
  //     "shop": "食堂",
  //     "foodname": "炒饭",
  //     "foodprice": "88",
  //     "delivername": "李明",
  //     "phone": "13833615605",
  //     "isExpanded": "0"
  //   },
  //   {
  //     "time": "11-30",
  //     "shop": "食堂",
  //     "foodname": "炒饭",
  //     "foodprice": "88",
  //     "delivername": "李明",
  //     "phone": "13833615605",
  //     "isExpanded": "0"
  //   },
  //   {
  //     "time": "11-30",
  //     "shop": "食堂",
  //     "foodname": "炒饭",
  //     "foodprice": "88",
  //     "delivername": "李明",
  //     "phone": "13833615605",
  //     "isExpanded": "0"
  //   },
  //   {
  //     "time": "11-30",
  //     "shop": "食堂",
  //     "foodname": "炒饭",
  //     "foodprice": "88",
  //     "delivername": "李明",
  //     "phone": "13833615605",
  //     "isExpanded": "0"
  //   },
  //   {
  //     "time": "11-30",
  //     "shop": "食堂",
  //     "foodname": "炒饭",
  //     "foodprice": "88",
  //     "delivername": "李明",
  //     "phone": "13833615605",
  //     "isExpanded": "0"
  //   },
  //   {
  //     "time": "11-30",
  //     "shop": "食堂",
  //     "foodname": "炒饭",
  //     "foodprice": "88",
  //     "delivername": "李明",
  //     "phone": "13833615605",
  //     "isExpanded": "0"
  //   },
  //   {
  //     "time": "11-30",
  //     "shop": "食堂",
  //     "foodname": "炒饭",
  //     "foodprice": "88",
  //     "delivername": "李明",
  //     "phone": "13833615605",
  //     "isExpanded": "0"
  //   },
  //   {
  //     "time": "11-30",
  //     "shop": "食堂",
  //     "foodname": "炒饭",
  //     "foodprice": "88",
  //     "delivername": "李明",
  //     "phone": "13833615605",
  //     "isExpanded": "0"
  //   },
  //   {
  //     "time": "11-30",
  //     "shop": "食堂",
  //     "foodname": "炒饭",
  //     "foodprice": "88",
  //     "delivername": "李明",
  //     "phone": "13833615605",
  //     "isExpanded": "0"
  //   },
  //   {
  //     "time": "11-30",
  //     "shop": "食堂",
  //     "foodname": "炒饭",
  //     "foodprice": "88",
  //     "delivername": "李明",
  //     "phone": "13833615605",
  //     "isExpanded": "0"
  //   },
  //   {
  //     "time": "11-30",
  //     "shop": "食堂",
  //     "foodname": "炒饭",
  //     "foodprice": "88",
  //     "delivername": "李明",
  //     "phone": "13833615605",
  //     "isExpanded": "0"
  //   },
  // ];
  final List<int> mlist = [1, 2, 3];


  @override
  Widget build(BuildContext context) {

    Widget _header(item) {
      return SizedBox(
        height: 20.0,
        child: Row(
          children: [
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${item["foodname"]}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${item["time"]}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                )
              ],
            ))
          ],
        ),
      );
    }

    Widget _expand(item) {
      return Column(
        children: [
          const Divider(
            thickness: 1.0,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10.0),
            child: Text(
              '起始：${item["shop"]}',
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10.0),
            child: Text(
              '价格：${item["foodprice"]}元',
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10.0),
              child: Text(
                '骑手：${item["delivername"]}',
              )),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10.0),
            child: Text(
              '联系电话：${item["phone"]}',
            ),
          ),
          Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    receiveOrders.removeAt(receiveOrders.indexOf(item));
                  });
                },
                child: const Text('已收到'),
              )),
        ],
      );
    }

    Widget _buildPanel() {
      return ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            if (receiveOrders[index]["isExpanded"] == "0") {
              receiveOrders[index]["isExpanded"] = "1";
            } else {
              receiveOrders[index]["isExpanded"] = "0";
            }
          });
        },
        children: receiveOrders.map((item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return _header(item);
            },
            body: _expand(item),
            isExpanded: item["isExpanded"] == "0" ? false : true,
            canTapOnHeader: false,
          );
        }).toList(),
      );
    }

    return Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              decoration: BoxDecoration(
                  //border: new Border.all(color: Color(0xFF3E3737), width: 2),
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular((30.0))),
              child: Column(
                children: [
                  _buildPanel(),
                ],
              )),
        ));
  }
}

class _Order_ReceiveRoute extends StatelessWidget {


  late List receiveOrders = [];



  @override
  Widget build(BuildContext context) {
    receiveOrders = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        title: const Text("收餐"),
      ),
      body: Center(child: ExpansionList(receiveOrders)),
    );
  }
}

// class _ExpansionPanelPageState extends State<HistoryOrder> {
//   List<Item> _data = generateItems(20);
//
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         title: Text('HistoryOrder'),
//         leading: new IconButton(
//           //这是图标长按会出现的提示信息，返回按钮这么常用，应该不需要吧
//           //tooltip: '返回上一页',
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pushNamed(context, "/");
// //            Navigator.push(context, MaterialPageRoute(builder: (context) {
// //              return SecondScreen();
// //            }));
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: _buildPanel(),
//         ),
//       ),
//     ));
//   }
//
//   Widget _buildPanel() {
//     return ExpansionPanelList(
//       expansionCallback: (int index, bool isExpanded) {
//         setState(() {
//           _data[index].isExpanded = !isExpanded;
//         });
//       },
//       children: _data.map<ExpansionPanel>((Item item) {
//         return ExpansionPanel(
//           headerBuilder: (BuildContext context, bool isExpanded) {
//             return ListTile(
//               title: Text(item.headerValue),
//             );
//           },
//           body: ListTile(
//               title: Text(item.expandedValue),
//               subtitle: Text('To delete this panel, tap the trash can icon'),
//               trailing: Icon(Icons.delete),
//               onTap: () {
//                 setState(() {
//                   _data.removeWhere((currentItem) => item == currentItem);
//                 });
//               }),
//           isExpanded: item.isExpanded,
//         );
//       }).toList(),
//     );
//   }
// }
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
