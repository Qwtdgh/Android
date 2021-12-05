part of main;


class _OrderGetPage extends StatelessWidget {

  late int userID = -1;
  _OrderGetPage(int userID) {
    this.userID = userID;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        appBar: AppBar(
          title: const Text("抢单"),
        ),
        body: _Order_Get_List(this.userID),
      ),
    );
  }
}


class _Order_Get_List extends StatefulWidget {

  late int userID = -1;
  _Order_Get_List(int userID) {
    this.userID = userID;
  }

  @override
  createState() => _Order_Get_List_State(this.userID);
}

class _Order_Get_List_State extends State<_Order_Get_List> {
  late List MissedOrders = [];
  late int userID = -1;
  _Order_Get_List_State(int userID) {
    this.userID = userID;
  }

  getMissed() async {
    // CustomSnackBar(context, const Text('Login button pressed'));
    int length = 0;
    var baseUrl = "http://delivery.mcatk.com";
    var uri = "/api/getAllOrders/";
    var body = {};
    http.Response response = await http.post(Uri.parse(baseUrl + uri), body: Convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    var result = Convert.jsonDecode(responseBody);
    print('${statusCode}');
    print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
    this.MissedOrders = result["orders"];
    setState(() {
      this.MissedOrders = result["orders"];
    });
  }

  takeOrder(int userID, int orderID) async {
    // CustomSnackBar(context, const Text('Login button pressed'));
    int length = 0;
    var baseUrl = "http://delivery.mcatk.com";
    var uri = "/api/takeOrder/";

    var body = {"userID": userID.toString(), "orderID": orderID.toString()};
    http.Response response = await http.post(Uri.parse(baseUrl + uri), body: Convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    var result = Convert.jsonDecode(responseBody);
    print('${statusCode}');
    print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
  }

  @override
  Widget build(BuildContext context) {
    getMissed();
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: MissedOrders.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            //height: 700,
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
                                  '订单号：${MissedOrders[index]["orderID"]}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${MissedOrders[index]["orderDate"]}',
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
                                  '收货人：${MissedOrders[index]["orderUserNickName"]}',
                                  style: const TextStyle(fontSize: 15.0),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '目的地：${MissedOrders[index]["orderUserAddress"]}',
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
                      itemCount: MissedOrders[index]["food"].length,
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
                                    Image.network('${MissedOrders[index]["food"][fi]["foodUrl"]}', height: 80.0,),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Expanded(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20.0,),
                                      Container(
                                        child: Text(
                                          '${MissedOrders[index]["food"][fi]["foodName"]}',
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      SizedBox(height: 30.0,),
                                      Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                  '单价：${MissedOrders[index]["food"][fi]["foodPrice"]}',
                                                  textAlign: TextAlign.left,
                                                )
                                            ),
                                            Expanded(
                                                child:Text(
                                                  '数量：${MissedOrders[index]["food"][fi]["foodNum"]}',
                                                  textAlign: TextAlign.right,
                                                )
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                              ),

                            ],
                          ),
                        );

                      }),
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
                              '接单',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            onPressed: () {
                              takeOrder(this.userID, MissedOrders[index]["orderID"]);

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

