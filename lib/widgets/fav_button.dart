import 'package:flutter/cupertino.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class _Global {
  static int userID = 0;
  static var foodID = 0;
  static bool isFav = false;
}

class FavButton extends StatefulWidget {

  FavButton(userID, foodID) {
    _Global.userID = userID;
    _Global.foodID = foodID;
  }

  @override
  _FavButtonState createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  @override
  Widget build(BuildContext context) {
    getIsFavorite(context);
    return Container(
      padding: const EdgeInsets.only(left: 5.0),
      height: 40.0,
      width: 40.0,
      child: Center(
          child: FavoriteButton(
            isFavorite: _Global.isFav,
            iconDisabledColor: Colors.white,
            iconSize: 30.0,
            valueChanged: (_isFavorite) {
              if (_isFavorite) {
                setFav(context);
              } else {
                unsetFav(context);
              }
            },
          )
      ),
    );
  }

  setFav(BuildContext context) async {
    var baseUrl = "http://42.192.60.125";
    var uri = "/api/setStar/";
    var body = {
      'userID': _Global.userID,
      'foodID': _Global.foodID,
    };
    http.Response response = await http.post(Uri.parse(baseUrl + uri), body: convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    // print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
  }

  unsetFav(BuildContext context) async {
    var baseUrl = "http://42.192.60.125";
    var uri = "/api/unStar/";
    var body = {
      'userID': _Global.userID,
      'foodID': _Global.foodID,
    };
    http.Response response = await http.post(Uri.parse(baseUrl + uri), body: convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    // print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
  }

  getIsFavorite(BuildContext context) async {
    var baseUrl = "http://42.192.60.125";
    var uri = "/api/getEvaluateFood/";
    var body = {
      'userID': _Global.userID,
      'foodID': _Global.foodID,
    };
    http.Response response = await http.post(Uri.parse(baseUrl + uri), body: convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    var result = convert.jsonDecode(responseBody);
    // print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');

    setState(() {
      _Global.isFav = result['food']['hasStared'];
    });
    // print(isFav);
  }
}
