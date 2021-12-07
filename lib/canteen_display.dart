import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:delivery/cart.dart';
import 'package:delivery/dish_display.dart';

class PassDataStore {
  final dynamic store;
  final int userID;

  PassDataStore(this.store, this.userID);
}

class CanteenInfo extends StatelessWidget {
  late var userID;
  late var store;
  late var shoppingList = [];

  @override
  Widget build(BuildContext context) {
    PassDataStore tmp = ModalRoute.of(context)!.settings.arguments as PassDataStore;
    store = tmp.store;
    userID = tmp.userID;
    return Scaffold(
      appBar: AppBar(
        title: Text(store['storeName']),
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
        child: _CanteenInfoPage(store, userID, shoppingList),
      ),
    );
  }
}

class _CanteenInfoPage extends StatelessWidget {
  late var store;
  late var userID;
  late var shoppingList = [];

  _CanteenInfoPage(this.store, this.userID, this.shoppingList);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 13, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          renderCanteenInfo(), // Row
          // renderAddToChart(), // Button
          renderMenu(context),
        ],
      ),
    );
  }

  Widget renderCanteenInfo() {
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              child: Image.network(
                store['storeUrl'],
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              // verticalDirection: Ver,
              children: [
                renderInfoLine(Icons.local_restaurant, store['storeName']),
                renderInfoLine(
                    Icons.place, store['storeAddress']),
                renderInfoLine(
                    Icons.phone, store['storeTel']),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget renderInfoLine(IconData icon, String str) {
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
    return Row(
      children: [
        Container(
            margin: const EdgeInsets.only(
              right: 4.0,
            ),
            child: Icon(icon)),
        Text(
          str,
          style: textStyle,
        ),
      ],
    );
  }

  Widget renderMenu(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: 320,
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            _MenuRoot(store['food'], userID, shoppingList),
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
                    Navigator.pushNamed(context, '/cart', arguments: PassDataCart(shoppingList, userID));
                  },
                  child: const Icon(Icons.shopping_cart),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuRoot extends StatelessWidget {
  late var userID;
  late var foodList;
  late var shoppingList;
  _MenuRoot(this.foodList, this.userID, this.shoppingList);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        itemCount: foodList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          return _MenuSuggestedDishCard(foodList[index], userID, shoppingList);
        },
      ),
    );
  }
}

class _MenuSuggestedDishCard extends StatelessWidget {
  late var food;
  late var userID;
  late var shoppingList;

  _MenuSuggestedDishCard(this.food, this.userID, this.shoppingList);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/canteen/dishdisplay', arguments: PassDataDish(food, userID, shoppingList));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(1, 1, 1, 1),
        child: renderCover(),
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
            food['foodUrl'],
            height: 100,
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
                food['foodName'],
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
