import 'dart:convert' as convert;
import 'package:delivery/widgets/dish_card.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:delivery/dish_display.dart';
import 'package:delivery/cart.dart';

class _Global {
  static int userID = 0;
}

class HomePage extends StatefulWidget {
  HomePage(userID) {
    _Global.userID = userID;
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => _HomeRoot(),
        '/home/dishdisplay': (context, {arguments}) => DishInfo(),
        // '/receive': (context) => const _Order_ReceiveRoute(),
        '/cart': (context) => ShoppingCart(),
      },
    );
  }
}

class _HomeRoot extends StatefulWidget {

  @override
  _HomeRootState createState() => _HomeRootState();
}

class _HomeRootState extends State<_HomeRoot> {
  var topFoodList = [];
  getAll(BuildContext context) async {
    var baseUrl = "http://delivery.mcatk.com";
    var uri = "/api/getTopFoodList/";
    var body = {};
    http.Response response = await http.post(Uri.parse(baseUrl + uri), body: convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    var result = convert.jsonDecode(responseBody);
    print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');

    setState(() {
      topFoodList = result["food"];
    });
    print(topFoodList);
  }

  @override
  Widget build(BuildContext context) {
    getAll(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          foregroundColor: Colors.black,
          backgroundColor: Colors.yellow,
        ),
        body: Center(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1.0,
            ),
            itemCount: topFoodList.length,
            itemBuilder: (context, index) {
              return SuggestedDishCard(topFoodList[index], _Global.userID);
            },
          ),
        ));
  }
}
