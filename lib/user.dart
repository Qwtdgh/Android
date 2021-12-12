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
        "/likes": (context) => _Home_Root1(this.userID),
        "/sendOrder": (context) => _Order_SendRoute(this.userID, false),
        "/receiveOrder": (context) => _Order_ReceiveRoute(this.userID, false),
        "/sendOrderHistory": (context) => _Order_SendRoute(this.userID, true),
        "/receiveOrderHistory": (context) => _Order_ReceiveRoute(this.userID, true),
        "/changePassword": (context) => TextFieldAndCheckPage(this.userID),
        "/login": (context) => LoginPage(),
        "/main": (context, {arguments}) => Main_Page(),
      },
    );
  }
}

class TextFieldAndCheckPage extends StatefulWidget {
  late int userID = -1;

  @override
  TextFieldAndCheckPage(int userID) : this.userID = userID;

  State<StatefulWidget> createState() => TextFieldAndCheckPageState(userID);
}

class TextFieldAndCheckPageState extends State<TextFieldAndCheckPage> {
  late int userID = -1;
  late String oldPassword = "";
  late String newPassword = "";

  //手机号的控制器
  TextFieldAndCheckPageState(int userID) : this.userID = userID;
  TextEditingController oldpassController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('输入和选择'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: oldpassController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.lock),
              labelText: '请输入您的旧密码)',
              // helperText: '请输入您的新密码',
            ),
            autofocus: false,
          ),
          TextField(
              controller: passController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.lock),
                labelText: '请输入您的新密码)',
              ),
              obscureText: true),
          ElevatedButton(
            onPressed: () async {
              // CustomSnackBar(context, const Text('Login button pressed'));

              var baseUrl = "http://42.192.60.125";
              var uri = "/api/changePassword/";
              var body = {
                "userID": this.userID.toString(),
                "userOldPassword": oldpassController.text,
                "userPassword": passController.text
              };
              http.Response response = await http.post(Uri.parse(baseUrl + uri),
                  body: convert.jsonEncode(body));
              final statusCode = response.statusCode;
              final responseBody = response.body;
              var result = convert.jsonDecode(responseBody);
              print(
                  '[uri=$uri][statusCode=$statusCode][response=$responseBody]');

              //var http =  HttpRequest("http://delivery.mcatk.com");

              //Map<String, String> ret = http.post("/api/login/", body) as Map<String, String>;
              //String? userID = ret["userID"];
              var userID = result["userID"];
              print(userID);
              Navigator.pushNamed(context, "/login");
            },
            child: Text('重新登陆'),
          ),
        ],
      ),
    );
  }

  /*void _login() {
    print({'phone': oldpassController.text, 'password': passController.text});
    if (oldpassController.text.length != 11) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('手机号码格式不对'),
              ));
    } else if (passController.text.length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('请填写密码'),
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('登录成功'),
              ));
      oldpassController.clear();
    }
  }*/

  void onTextClear() {
    setState(() {
      oldpassController.clear();
      passController.clear();
    });
  }
}

class HomeRootList extends StatefulWidget {
  late int userID = -1;

  HomeRootList(int userID) {
    this.userID = userID;
  }

  @override
  createState() => _Home_RootState(this.userID);
}

class _Home_RootState extends State<HomeRootList> {
  //_Home_Root({Key? key}) : super(key: key);
  late int userID = -1;
  List stars = [];

  _Home_RootState(int userID) {
    this.userID = userID;
  }

  getAll(BuildContext context) async {
    // CustomSnackBar(context, const Text('Login button pressed'));

    var baseUrl = "http://42.192.60.125";
    var uri = "/api/getInformation/";
    var body = {"userID": this.userID.toString()};
    http.Response response = await http.post(Uri.parse(baseUrl + uri),
        body: convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    var result = convert.jsonDecode(responseBody);
    print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');

    //var http =  HttpRequest("http://delivery.mcatk.com");

    //Map<String, String> ret = http.post("/api/login/", body) as Map<String, String>;
    //String? userID = ret["userID"];
    var userID = result["userID"];
    print(userID);
    setState(() {
      this.stars = result['userStars'];
    });
    // Navigator.pushNamed(context, "/main", arguments: userID);
  }

  // DishInfo dishInfo = const DishInfo(
  //   dishImgUrl:
  //   'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimgsa.baidu.com%2Fexp%2Fw%3D500%2Fsign%3D449be3d66381800a6ee5890e813433d6%2F8694a4c27d1ed21b9b3734bca26eddc450da3fe8.jpg&refer=http%3A%2F%2Fimgsa.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1640937777&t=f86139b4672f345a1a881cc08deb4aeb',
  //   dishName: '宫保鸡丁',
  //   dishPlace: '合一食堂',
  //   dishPrice: 30000,
  //   comments: ['Great', 'Garbage', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge'],
  // );

  @override
  Widget build(BuildContext context) {
    getAll(context);
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Home'),
        //   foregroundColor: Colors.black,
        //   backgroundColor: Colors.yellow,
        // ),
        body: Center(
      child: GridView.builder(
        itemCount: stars.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) {
          return SuggestedDishCard(stars[index], userID);
        },
      ),
    ));
  }
}

class _Home_Root1 extends StatelessWidget {
  late int userID;

  _Home_Root1(int userID) {
    this.userID = userID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Myself"),
      ),
      backgroundColor: Color(0xfff7c341),
      body: HomeRootList(this.userID),
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
  late List sendOrdersHistory = [];
  late List receiveOrdersHistory = [];
  late List likes = [];
  late String iconUrl = "";

  MyselfListState(int userID) {
    this.userID = userID;
  }

  getAll() async {
    // CustomSnackBar(context, const Text('Login button pressed'));

    var baseUrl = "http://42.192.60.125";
    var uri = "/api/getInformation/";
    var body = {"userID": this.userID.toString()};
    http.Response response = await http.post(Uri.parse(baseUrl + uri),
        body: convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    var result = convert.jsonDecode(responseBody);
    print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');

    this.sendOrders = [];
    this.receiveOrders = [];
    this.sendOrdersHistory = [];
    this.receiveOrdersHistory = [];
    this.sendOrders.addAll(result["userDeliveryOrders"]);
    this.receiveOrders.addAll(result["userOrders"]);
    this.sendOrdersHistory.addAll(result["userDeliveryOrders"]);
    this.receiveOrdersHistory.addAll(result["userOrders"]);

    setState(() {
      this.userNickname = result["userNickName"];
      this.userAddress = result["userAddress"];
      this.userTel = result["userTel"];
      this.receiveOrders.removeWhere((element) => element["orderCompleted"] == 2);
      this.sendOrders.removeWhere((element) => element["orderCompleted"] == 0 || element["orderCompleted"] == 2);
      this.receiveOrdersHistory.removeWhere((element) => element["orderCompleted"] == 0 || element["orderCompleted"] == 1);
      this.sendOrdersHistory.removeWhere((element) => element["orderCompleted"] == 1);
      // this.sendOrders = result["userDeliveryOrders"];
      this.likes = result["userStars"];
      this.iconUrl = result["userIconUrl"];
      print(iconUrl);
    });
    // Navigator.pushNamed(context, "/main", arguments: userID);
  }

  @override
  Widget build(BuildContext context) {
    getAll();

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
                      child: Image.network(this.iconUrl)),
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

                        Navigator.pushNamed(context, "/changePassword");
                      },
                      icon: Icon(
                        Icons.lock,
                        size: 32.0,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     //修改信息部分
                    //     //需要调用修改信息的函数
                    //
                    //     Navigator.pushNamed(context, "/changePassword");
                    //   },
                    //   icon: Icon(
                    //     Icons.lock,
                    //     size: 32.0,
                    //   ),
                    // ),
                  ],
                ),
              ],
            )),
      );
    }

    Card _shapeCard0(BuildContext context, String str, String route) {
      bool flag0 = true, flag1 = true, flag2 = true, flag3 = true, flag4 = true;
      if (this.sendOrders.isEmpty) {
        flag0 = false;
      }
      if (this.receiveOrders.isEmpty) {
        flag1 = false;
      }
      if (this.likes.isEmpty) {
        flag2 = false;
      }
      if (this.sendOrdersHistory.isEmpty) {
        flag3 = false;
      }
      if (this.receiveOrdersHistory.isEmpty) {
        flag4 = false;
      }

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
                  badgeContent: Text('${this.sendOrders.length}'),
                  child: Container(
                      height: 80,
                      width: 40,
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/sendOrder",
                                  arguments: 1);
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
                  showBadge: flag0,
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
                  badgeContent: Text('${this.receiveOrders.length}'),
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
                  showBadge: flag1,
                  //true时刷新时会在右则摆动一下
                  animationDuration: Duration(seconds: 10),
                  //小点点在右侧摆动的时间,这里为10秒
                  toAnimate: true, //允许摆动，false时showBadge会失效
                ),
                Badge(
                  //文本内容Text为空时子组件为null时则返回一个红点，其他值时按实际显示
                  badgeContent: Text('${this.likes.length}'),
                  child: Container(
                      height: 80,
                      width: 40,
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/likes");
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
                  showBadge: flag2,
                  //true时刷新时会在右则摆动一下
                  animationDuration: Duration(seconds: 10),
                  //小点点在右侧摆动的时间,这里为10秒
                  toAnimate: true, //允许摆动，false时showBadge会失效
                ),
                Badge(
                  //文本内容Text为空时子组件为null时则返回一个红点，其他值时按实际显示
                  badgeContent: Text('${this.sendOrdersHistory.length}'),
                  child: Container(
                      height: 80,
                      width: 40,
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/sendOrderHistory");
                            },
                            icon: Icon(
                              Icons.update,
                              size: 32.0,
                            ),
                          ),
                          Text(
                            "历史送",
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
                  showBadge: flag3,
                  //true时刷新时会在右则摆动一下
                  animationDuration: Duration(seconds: 10),
                  //小点点在右侧摆动的时间,这里为10秒
                  toAnimate: true, //允许摆动，false时showBadge会失效
                ),
                Badge(
                  //文本内容Text为空时子组件为null时则返回一个红点，其他值时按实际显示
                  badgeContent: Text('${this.receiveOrdersHistory.length}'),
                  child: Container(
                      height: 80,
                      width: 40,
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/receiveOrderHistory");
                            },
                            icon: Icon(
                              Icons.playlist_add_check,
                              size: 32.0,
                            ),
                          ),
                          Text(
                            "历史订",
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
                  showBadge: flag4,
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

// class Wallet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Wallet"),
//       ),
//       body: Center(
//         child: RaisedButton(
//           child: Text("跳回首页"),
//           onPressed: () {
//             Navigator.pushNamed(context, "/");
// //            Navigator.push(context, MaterialPageRoute(builder: (context) {
// //              return SecondScreen();
// //            }));
//           },
//         ),
//       ),
//     );
//   }
// }
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

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: "name $index",
      expandedValue: 'This is item number $index',
    );
  });
}

class MyList extends StatefulWidget {
  late int userID = -1;
  late bool isHistory = false;
  MyList(int userID, bool isHistory) {
    this.userID = userID;
    this.isHistory = isHistory;
  }

  @override
  createState() => MyListState(this.userID, this.isHistory);
}

class MyListState extends State<MyList> {
  late int userID = -1;
  late List sendOrders = [];
  late bool isHistory = false;

  MyListState(int userID, bool isHistory) {
    this.userID = userID;
    this.isHistory = isHistory;
  }



  getSend() async {
    // CustomSnackBar(context, const Text('Login button pressed'));
    // int length = 0;
    var baseUrl = "http://delivery.mcatk.com";
    var uri = "/api/getInformation/";
    var body = {"userID": this.userID.toString()};
    http.Response response = await http.post(Uri.parse(baseUrl + uri),
        body: convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    var result = convert.jsonDecode(responseBody);
    //print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
    this.sendOrders = result["userDeliveryOrders"];
    setState(() {
      this.sendOrders = result["userDeliveryOrders"];
      if (!isHistory) {
        this.sendOrders.removeWhere((element) =>
        element["orderCompleted"] == 0 || element["orderCompleted"] == 2);
      } else {
        this.sendOrders.removeWhere((element) =>
        element["orderCompleted"] == 0 || element["orderCompleted"] == 1);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    getSend();
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: sendOrders.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            //height: 150,
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
                              '订单号：${sendOrders[index]["orderID"]}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${sendOrders[index]["orderDate"]}',
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
                              '收货人：${sendOrders[index]["orderUserNickName"]}',
                              style: const TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '目的地：${sendOrders[index]["orderUserAddress"]}',
                              style: const TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
                Container(
                  //height: 400.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics:NeverScrollableScrollPhysics(),
                      itemCount: sendOrders[index]["food"].length,
                      itemBuilder: (BuildContext context, int fi) {
                        return Container(
                          child: Row(
                            children: [
                              Container(
                                width: 100.0,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 5.0, top: 20.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      '${sendOrders[index]["food"][fi]["foodUrl"]}',
                                      height: 80.0,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                  child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    child: Text(
                                      '${sendOrders[index]["food"][fi]["foodName"]}',
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          '单价：${sendOrders[index]["food"][fi]["foodPrice"]}',
                                          textAlign: TextAlign.left,
                                        )),
                                        Expanded(
                                            child: Text(
                                          '数量：${sendOrders[index]["food"][fi]["foodNum"]}',
                                          textAlign: TextAlign.right,
                                        ))
                                      ],
                                    ),
                                  )
                                ],
                              )),
                            ],
                          ),
                        );
                      }),
                ),
                // Row(
                //   children: [
                //     Expanded(
                //         child: Container(
                //       alignment: Alignment.centerRight,
                //       margin: const EdgeInsets.only(right: 10.0, top: 20.0),
                //       child: ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //             shadowColor: Colors.red,
                //             fixedSize: const Size.fromHeight(10)),
                //         child: const Text(
                //           '已送达',
                //           style: TextStyle(fontSize: 15.0),
                //         ),
                //         onPressed: () {
                //           setState(() {
                //             sendOrders.removeAt(index);
                //           });
                //         },
                //       ),
                //     ))
                //   ],
                // ),
              ],
            ),
          );
        });
  }
}

class _Order_SendRoute extends StatelessWidget {
  late int userID = -1;
  late bool isHistory = false;

  _Order_SendRoute(int userID, bool isHistory) {
    this.userID = userID;
    this.isHistory = isHistory;
  }

  @override
  Widget build(BuildContext context) {
    // final List<int> colorCodes = <int>[600, 500, 100];

    return Scaffold(
      appBar: AppBar(
        title: Text("${this.isHistory ? "送餐历史" : "送餐"}"),
        shadowColor: Colors.yellow,
      ),
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: MyList(this.userID, this.isHistory),
    );
  }
}

class ExpansionList extends StatefulWidget {
  late int userID = -1;
  late List isExpands = [];
  late bool isHistory = false;

  ExpansionList(int userID, List isExpands, isHistory) {
    this.userID = userID;
    this.isExpands = isExpands;
    this.isHistory = isHistory;
  }

  @override
  State createState() {
    return ExpansionListState(this.userID, this.isExpands, this.isHistory);
  }
}

class ExpansionListState extends State<ExpansionList> {
  late int userID = -1;
  late List receiveOrders = [];
  late List isExpands = [];
  late bool isHistory = false;

  ExpansionListState(int userID, List isExpands, isHistory) {
    this.userID = userID;
    this.isExpands = isExpands;
    this.isHistory = isHistory;
  }


  getReceive() async {
    // CustomSnackBar(context, const Text('Login button pressed'));
    // int length = 0;
    var baseUrl = "http://delivery.mcatk.com";
    var uri = "/api/getInformation/";
    var body = {"userID": this.userID.toString()};
    http.Response response = await http.post(Uri.parse(baseUrl + uri),
        body: convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    var result = convert.jsonDecode(responseBody);
    //print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
    this.receiveOrders = result["userOrders"];
    setState(() {
      this.receiveOrders = result["userOrders"];
      if (!this.isHistory) {
        this.receiveOrders
            .removeWhere((element) => element["orderCompleted"] == 2);
      } else {
        this.receiveOrders
            .removeWhere((element) => element["orderCompleted"] == 0 || element["orderCompleted"] == 1);
      }

    });
  }

  finishOrder(int orderID) async {
    var baseUrl = "http://delivery.mcatk.com";
    var uri = "/api/finishOrder/";
    var body = {"orderID": orderID.toString()};
    http.Response response = await http.post(Uri.parse(baseUrl + uri),
        body: convert.jsonEncode(body));
    //final statusCode = response.statusCode;
    //final responseBody = response.body;
    //var result = Convert.jsonDecode(responseBody);
    //print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getReceive();
  //   this.receiveOrders =
  // }

  @override
  Widget build(BuildContext context) {
    getReceive();

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
                    '${item["storeName"]}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${item["orderDate"]}',
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
            child: ListView.builder(
                shrinkWrap: true,
                physics:NeverScrollableScrollPhysics(),
                itemCount: item["food"].length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Row(
                      children: [
                        Container(
                          width: 100.0,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 5.0, top: 20.0),
                          child: Column(
                            children: [
                              Image.network(
                                '${item["food"][index]["foodUrl"]}',
                                height: 80.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              child: Text(
                                '${item["food"][index]["foodName"]}',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    '单价：${item["food"][index]["foodPrice"]}',
                                    textAlign: TextAlign.left,
                                  )),
                                  Expanded(
                                      child: Text(
                                    '数量：${item["food"][index]["foodNum"]}',
                                    textAlign: TextAlign.right,
                                  ))
                                ],
                              ),
                            )
                          ],
                        )),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10.0),
            child: Text(
              '总价格：${item["totalPrice"]}元',
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10.0),
              child: Text(
                '骑手：${item["deliveryUserNickName"] == null ? '无' : item["deliveryUserNickName"]}',
              )),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10.0),
            child: Text(
              '联系电话：${item["deliveryUserTel"] == null ? '无' : item["deliveryUserTel"]}',
            ),
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text('${ this.isHistory ?  "" : item["deliveryUserTel"] == null ? "无骑手配送" : '预测时间：${item["forecastTime"]}分钟'}'),
              ),
              Expanded(
                  child: Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 10.0),
                      child: ElevatedButton(
                        onPressed: (item["deliveryUserNickName"] == null || this.isHistory ? true : false)
                            ? null
                            : () {
                          finishOrder(item["orderID"]);
                        },
                        child: Text('${this.isHistory ? "已收到": "收货"}'),

                      )),
              ),
            ],
          ),

        ],
      );
    }

    Widget _buildPanel() {
      return ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            if (isExpands[index]) {
              isExpands[index] = false;
            } else {
              isExpands[index] = true;
            }
          });
        },
        children: receiveOrders.map((item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return _header(item);
            },
            body: _expand(item),
            isExpanded: isExpands[receiveOrders.indexOf(item)] ? true : false,
            canTapOnHeader: false,
          );
        }).toList(),
      );
    }

    return Container(
        child: SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 0),
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
  late int userID = -1;
  late List isExpands = [];
  late bool isHistory = false;

  _Order_ReceiveRoute(int userID, bool isHistory) {
    this.userID = userID;
    this.isHistory = isHistory;
    for (int i = 0; i < 1000; i++) {
      this.isExpands.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${this.isHistory ? "订餐历史" : "订餐"}"),
      ),
      body: Container(
          child: ExpansionList(this.userID, this.isExpands, this.isHistory)
      ),
    );
  }
}



