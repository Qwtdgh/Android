import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:delivery/canteen_display.dart';
import 'package:delivery/dish_display.dart';
import 'package:delivery/cart.dart';

class CanteenPage extends StatelessWidget {
  late var userID;
  CanteenPage(this.userID);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/canteen',
      routes: {
        '/canteen': (context) => _CanteenRoot(userID),
        '/canteen/canteendisplay': (context, {arguments}) => CanteenInfo(),
        '/canteen/dishdisplay': (context, {arguments}) => DishInfo(),
        '/cart': (context, {arguments}) => ShoppingCart(),
        // '/receive': (context) => const _Order_ReceiveRoute(),
      },
    );
  }
}

class _CanteenRoot extends StatefulWidget {
  late var userID;
  _CanteenRoot(this.userID);
  @override
  _CanteenRootState createState() => _CanteenRootState(userID);
}

class _CanteenRootState extends State<_CanteenRoot> {
  late var stores = [];
  late var userID;

  _CanteenRootState(this.userID);

  getAll(BuildContext context) async {
    var baseUrl = "http://42.192.60.125";
    var uri = "/api/getStores/";
    var body = {};
    http.Response response = await http.post(Uri.parse(baseUrl + uri), body: convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    var result = convert.jsonDecode(responseBody);
    print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');

    setState(() {
      stores = result["store"];
    });
    print(stores);
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
          child: ListView.builder(
            itemCount: stores.length,
            itemBuilder: (context, index) {
              return _CanteenCard(stores[index], userID);
            },
          ),
        ));
  }
}

class _CanteenCard extends StatelessWidget {
  late var store;
  late var userID;

  _CanteenCard(this.store, this.userID);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/canteen/canteendisplay',
            arguments: PassDataStore(store, userID));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 13, 16, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            renderCover(),
          ],
        ),
      ),
    );
  }

  Widget renderCover() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Image.network(
            store['storeUrl'],
            height: 180,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 100,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              alignment: Alignment.bottomLeft,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                ),
              ),
              child: Text(
                store['storeName'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
