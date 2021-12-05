library main;

import 'dart:convert';

import 'package:delivery/widgets/snackbar.dart';

import 'http.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert' as Convert;
import 'package:badges/badges.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

part 'dishes_display.dart';
part 'dish_display.dart';
part 'canteen.dart';
part 'canteen_display.dart';
part 'order_get.dart';
part 'user.dart';
part 'cart.dart';



//void main() => runApp(const MyApp());

class Main_Page extends StatelessWidget {
  const Main_Page({Key? key}) : super(key: key);
  static const String _title = 'My Demo';

  @override
  Widget build(BuildContext context) {

    late int userID = -1;
    userID = ModalRoute.of(context)!.settings.arguments as int;
    return MaterialApp(
      title: _title,
      home: _BottomSelection(userID),
    );
  }
}

class _BottomSelection extends StatefulWidget {

  late int userID;
  _BottomSelection(int userID) {
    this.userID = userID;
  }

  @override
  _BottomSelectionState createState() => _BottomSelectionState(userID);
}

class _BottomSelectionState extends State<_BottomSelection> {
  late var dishInfo;
  late int _selectedIndex;
  late List<Widget> _widgetOptions;
  late int userID;
  _BottomSelectionState(int userID) {
    this.userID = userID;
  }

  @override
  void initState() {
    super.initState();

    _selectedIndex = 0;

    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    _widgetOptions = <Widget>[
      _HomePage(this.userID),
      _CanteenPage(),
      _OrderGetPage(),
      _UserPage(this.userID),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('Home'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.yellow,
      ),*/
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.amber,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black38,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: 'My',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
