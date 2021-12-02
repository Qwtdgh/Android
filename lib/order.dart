part of main;

class _OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/order',
      routes: {
        '/': (context) => const _Order_Root(),
        '/send': (context) => const _Order_SendRoute(),
        '/receive': (context) => const _Order_ReceiveRoute(),
      },
    );
  }
}

class _Order_Root extends StatelessWidget {
  const _Order_Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // _http() {
    //   var httpTest = HttpRequest("http://10.135.210.143:8081/");
    //   var result =  httpTest.post("all", Convert.jsonEncode({"1":"2", "2":"3"}));
    //   print('${result.toString()}');
    // }
    return Scaffold(
        appBar: AppBar(title: const Text("订送单")),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                        )
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/send");
                  },
                  child: const Text('goto Send'),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                            )
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/receive");
                      },
                      child: const Text('goto Receive')
                  ),
              ),
              // new ElevatedButton(
              //     onPressed: () {
              //       _http();
              //     },
              //     child: new Text('g'))
            ],
          ),
        ));
  }
}

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

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
  const _Order_SendRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final List<int> colorCodes = <int>[600, 500, 100];

    return Scaffold(
      appBar: AppBar(
        title: const Text('送餐'),
      ),
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: const MyList(),
    );
  }
}

class ExpansionList extends StatefulWidget {
  const ExpansionList({Key? key}) : super(key: key);

  @override
  State createState() {
    return ExpansionListState();
  }
}

class ExpansionListState extends State<ExpansionList> {
  final List<Map<String, String>> _receiveInfo = [
    {
      "time": "11-30",
      "shop": "食堂",
      "foodname": "炒饭",
      "foodprice": "88",
      "delivername": "李明",
      "phone": "13833615605",
      "isExpanded": "0"
    },
    {
      "time": "11-30",
      "shop": "食堂",
      "foodname": "炒饭",
      "foodprice": "88",
      "delivername": "李明",
      "phone": "13833615605",
      "isExpanded": "0"
    },
    {
      "time": "11-30",
      "shop": "食堂",
      "foodname": "炒饭",
      "foodprice": "88",
      "delivername": "李明",
      "phone": "13833615605",
      "isExpanded": "0"
    },
    {
      "time": "11-30",
      "shop": "食堂",
      "foodname": "炒饭",
      "foodprice": "88",
      "delivername": "李明",
      "phone": "13833615605",
      "isExpanded": "0"
    },
    {
      "time": "11-30",
      "shop": "食堂",
      "foodname": "炒饭",
      "foodprice": "88",
      "delivername": "李明",
      "phone": "13833615605",
      "isExpanded": "0"
    },
    {
      "time": "11-30",
      "shop": "食堂",
      "foodname": "炒饭",
      "foodprice": "88",
      "delivername": "李明",
      "phone": "13833615605",
      "isExpanded": "0"
    },
    {
      "time": "11-30",
      "shop": "食堂",
      "foodname": "炒饭",
      "foodprice": "88",
      "delivername": "李明",
      "phone": "13833615605",
      "isExpanded": "0"
    },
    {
      "time": "11-30",
      "shop": "食堂",
      "foodname": "炒饭",
      "foodprice": "88",
      "delivername": "李明",
      "phone": "13833615605",
      "isExpanded": "0"
    },
    {
      "time": "11-30",
      "shop": "食堂",
      "foodname": "炒饭",
      "foodprice": "88",
      "delivername": "李明",
      "phone": "13833615605",
      "isExpanded": "0"
    },
    {
      "time": "11-30",
      "shop": "食堂",
      "foodname": "炒饭",
      "foodprice": "88",
      "delivername": "李明",
      "phone": "13833615605",
      "isExpanded": "0"
    },
    {
      "time": "11-30",
      "shop": "食堂",
      "foodname": "炒饭",
      "foodprice": "88",
      "delivername": "李明",
      "phone": "13833615605",
      "isExpanded": "0"
    },
  ];
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
                    _receiveInfo.removeAt(_receiveInfo.indexOf(item));
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
            if (_receiveInfo[index]["isExpanded"] == "0") {
              _receiveInfo[index]["isExpanded"] = "1";
            } else {
              _receiveInfo[index]["isExpanded"] = "0";
            }
          });
        },
        children: _receiveInfo.map((item) {
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
  const _Order_ReceiveRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("收餐"),
      ),
      body: const Center(child: ExpansionList()),
    );
  }
}
