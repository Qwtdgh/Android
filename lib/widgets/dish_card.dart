import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fav_button.dart';
import 'package:delivery/dish_display.dart';

class SuggestedDishCard extends StatelessWidget {
  late var userID;
  late var topFood;

  SuggestedDishCard(this.topFood, this.userID);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/home/dishdisplay',
            arguments: PassDataDish(topFood, userID, []));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 13, 16, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            renderCover(context),
            renderCanteen(),
          ],
        ),
      ),
    );
  }

  Widget renderCanteen() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        height: 100,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          alignment: Alignment.bottomLeft,
          child: Text(
            topFood['foodStoreName'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget renderCover(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Image.network(
            topFood['foodUrl'],
            height: 150,
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
                topFood['foodName'],
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 100,
            child: Container(
              // padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              alignment: Alignment.bottomRight,
              child: FavButton(userID, topFood['foodID']),
            ),
          ),
        ],
      ),
    );
  }
}
