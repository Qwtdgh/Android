import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PassDataCart {
  final List shoppingList;
  final int userID;

  PassDataCart(this.shoppingList, this.userID);
}

class _Global {
  static int userID = 0;
  static List shoppingList = [];
}

class ShoppingCart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var tmp = ModalRoute.of(context)!.settings.arguments as PassDataCart;
    _Global.userID = tmp.userID;
    _Global.shoppingList = tmp.shoppingList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.yellow,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_before),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: _CartBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setOrder(context);
        },
        child: const Icon(Icons.payment),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }

  setOrder(BuildContext context) async {
    var baseUrl = "http://delivery.mcatk.com";
    var uri = "/api/setOrders/";
    var list = [];
    for (var tmp in _Global.shoppingList) {
      list.add({'foodID': tmp['foodID'], 'foodNum': 1});
    }
    var body = {
      'userID': _Global.userID,
      'foodList': list,
    };
    http.Response response = await http.post(Uri.parse(baseUrl + uri), body: convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
  }
}

class _CartBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return _GuessYouLikePage();
  }
}

class _GuessYouLikePage extends StatefulWidget {
  @override
  _GuessYouLikePageState createState() => _GuessYouLikePageState();
}

class _GuessYouLikePageState extends State<_GuessYouLikePage> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _Global.shoppingList.length,
      itemBuilder: (BuildContext context, int index) {
        return _ShoppingCard(_Global.shoppingList[index]);
      },
    );
  }
}

class _ShoppingCard extends StatelessWidget {
  late var shoppingDish;

  _ShoppingCard(this.shoppingDish);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 25.0),
      getFoodItem(context, shoppingDish['foodName'], shoppingDish['foodUrl'],
          shoppingDish['foodPrice'], shoppingDish['foodStoreName'], 5),
      const SizedBox(height: 25.0),
      Padding(
        padding: const EdgeInsets.only(left: 125.0),
        child: Container(height: 1.0, color: Colors.grey),
      ),
    ]);
  }

  Widget getFoodItem(BuildContext context, String dishName, String imgUrl,
      String price, String canteen, int num) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 80.0,
              width: 80.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  image: DecorationImage(
                      image: NetworkImage(
                        imgUrl,
                      ),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    width: MediaQuery.of(context).size.width - 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          dishName,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                const SizedBox(height: 35.0),
                Row(
                  children: <Widget>[
                    const Icon(Icons.attach_money, color: Colors.grey),
                    Text(
                      price.toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 7.0),
                    const Icon(Icons.restaurant, color: Colors.grey),
                    Text(
                      canteen.toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 7.0),
                    const Icon(Icons.one_x_mobiledata, color: Colors.grey),
                    Text(
                      num.toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }
}
