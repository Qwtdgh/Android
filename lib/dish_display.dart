import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:delivery/widgets/fav_button.dart';
import 'package:delivery/cart.dart';

class _Global {

}

class PassDataDish {
  final dynamic food;
  final int userID;
  final List shoppingList;

  PassDataDish(this.food, this.userID, this.shoppingList);
}

class DishInfo extends StatelessWidget {
  late var food;
  late var userID;
  late List shoppingList;

  @override
  Widget build(BuildContext context) {
    PassDataDish pack = ModalRoute.of(context)!.settings.arguments as PassDataDish;
    food = pack.food;
    userID = pack.userID;
    shoppingList = pack.shoppingList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('DishInfo'),
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
        child: _DishInfoPage(food, userID, shoppingList),
      ),
    );
  }
}

class _DishInfoPage extends StatefulWidget {
  late var food;
  late var userID;
  late List shoppingList;

  _DishInfoPage(this.food, this.userID, this.shoppingList);

  @override
  _DishInfoPageState createState() => _DishInfoPageState(food, userID, shoppingList);
}

class _DishInfoPageState extends State<_DishInfoPage> {
  late var food;
  late var userID;
  late var starInfo = {};
  late var avrStar = 0.0;
  late List shoppingList;

  _DishInfoPageState(this.food, this.userID, this.shoppingList);

  getAll(BuildContext context) async {
    var baseUrl = "http://delivery.mcatk.com";
    var uri1 = "/api/androidGetUserFoodEvaluate/";
    var body1 = {
      'userID': userID,
      'foodID': food['foodID'],
    };
    http.Response response1 = await http.post(Uri.parse(baseUrl + uri1), body: convert.jsonEncode(body1));
    final statusCode1 = response1.statusCode;
    final responseBody1 = response1.body;
    var result1 = convert.jsonDecode(responseBody1);
    print('[uri=$uri1][statusCode=$statusCode1][response=$responseBody1]');

    var uri2 = "/api/androidGetFoodEvaluateScore/";
    var body2 = {
      'foodID': food['foodID'],
    };
    http.Response response2 = await http.post(Uri.parse(baseUrl + uri2), body: convert.jsonEncode(body2));
    final statusCode2 = response2.statusCode;
    final responseBody2 = response2.body;
    var result2 = convert.jsonDecode(responseBody2);
    print('[uri=$uri2][statusCode=$statusCode2][response=$responseBody2]');

    setState(() {
      starInfo = result1;
      avrStar = result2['evaluate'];
    });
    print(avrStar);
    print(starInfo);
  }

  @override
  Widget build(BuildContext context) {
    getAll(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 13, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          renderDishInfo(), // Row
          renderStars(), // Star
          renderMyStars(context), // My Stars
          renderAddToChart(), // Button
          renderComment(context), // ListView
        ],
      ),
    );
  }

  Widget renderDishInfo() {
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 165,
              maxWidth: 165,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  Image.network(
                    food['foodUrl'],
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 100,
                    child: Container(
                        // padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        alignment: Alignment.bottomRight,
                        child: FavButton(userID, food['foodID']),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              // verticalDirection: Ver,
              children: [
                Text(
                  '名称：\t' + food['foodName'],
                  style: textStyle,
                ),
                Text(
                  '食堂：\t' + food['foodStoreName'],
                  style: textStyle,
                ),
                Text(
                  '价格：\t' + food['foodPrice'],
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget renderStars() {
    return Container(
      margin: const EdgeInsets.all(5),
      // constraints: const BoxConstraints.expand(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Ratings:',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SmoothStarRating(
              starCount: 5,
              rating: avrStar.toDouble(),
              size: 40.0,
              isReadOnly: true,
              filledIconData: Icons.star,
              color: Colors.yellow,
              borderColor: Colors.yellow,
              spacing: 0.0),
        ],
      ),
    );
  }

  setStar(BuildContext context, double v) async {
    var baseUrl = "http://delivery.mcatk.com";
    var uri = "/api/evaluateFood/";
    var body = {
      'postUserID': userID,
      'foodID': food['foodID'],
      'evaluateText': '',
      'evaluateScore': v,
    };
    http.Response response = await http.post(Uri.parse(baseUrl + uri), body: convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    var result = convert.jsonDecode(responseBody);
    print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
  }

  Widget renderMyStars(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      // constraints: const BoxConstraints.expand(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'My Rating:',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SmoothStarRating(
              onRated: (v) {
                setStar(context, v);
              },
              starCount: 5,
              rating: starInfo == {} ? (starInfo['success'] ? starInfo['evaluate']['evaluateScore'].toDouble() : 0.0) : 0.0,
              size: 40.0,
              isReadOnly: false,
              filledIconData: Icons.star,
              color: Colors.grey,
              borderColor: Colors.grey,
              spacing: 0.0),
        ],
      ),
    );
  }

  Widget renderAddToChart() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
        constraints: const BoxConstraints(minHeight: 50, minWidth: 250),
        alignment: Alignment.bottomLeft,
        // padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: const Text(
          'Comments:',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      Container(
          constraints: const BoxConstraints(minHeight: 50, minWidth: 20),
          alignment: Alignment.topRight,
          margin: const EdgeInsets.all(1),
          child: ElevatedButton(
            child: const Icon(Icons.add_shopping_cart),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              primary: Colors.red,
              padding: const EdgeInsets.all(8),
              shadowColor: Colors.grey,
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.yellow,
              ),
            ),
            onPressed: () {
              shoppingList.add(food);
            },
          )),
    ]);
  }

  Widget renderComment(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          _CommentDisplay(food['foodEvaluate']),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 100,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              alignment: Alignment.bottomRight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cart',
                      arguments: PassDataCart(shoppingList, userID));
                },
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentDisplay extends StatelessWidget {
  late var comments;

  _CommentDisplay(this.comments);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEFEFEF),
      child: SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return _CommentCard(comments[index]);
          },
        ),
      ),
    );
  }
}

class _CommentCard extends StatelessWidget {
  late var comment;

  _CommentCard(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: Text(
        '"' + comment['evaluateText'] + '"',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}
