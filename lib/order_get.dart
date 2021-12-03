part of main;

class _OrderGetPage extends StatelessWidget {
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
          title: Text("抢单"),
        ),
        body: _Order_Get_List(),
      ),
    );
  }
}


class _Order_Get_List extends StatefulWidget {
  const _Order_Get_List({Key? key}) : super(key: key);

  @override
  createState() => _Order_Get_List_State();
}

class _Order_Get_List_State extends State<_Order_Get_List> {
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

