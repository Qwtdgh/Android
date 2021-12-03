library main;

import 'http.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert' as Convert;

part 'dishes_display.dart';
part 'dish_display.dart';
part 'order.dart';
part 'canteen.dart';
part 'canteen_display.dart';
part 'order_get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'My Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: _BottomSelection(),
    );
  }
}

class _BottomSelection extends StatefulWidget {
  const _BottomSelection({Key? key}) : super(key: key);

  @override
  _BottomSelectionState createState() => _BottomSelectionState();
}

class _BottomSelectionState extends State<_BottomSelection> {
  late var dishInfo;
  late int _selectedIndex;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();

    _selectedIndex = 0;

    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    _widgetOptions = <Widget>[
      _HomePage(),
      const Text(
        'Index 1: Hot Dishes',
        style: optionStyle,
      ),
      _CanteenPage(),
      /*const Text(
        'Index 2: Category',
        style: optionStyle,
      ),*/
      /*const Text(
        'Index 3: Order',
        style: optionStyle,
      ),*/
      _OrderGetPage(),
      const Text(
        'Index 4: My',
        style: optionStyle,
      ),
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
            icon: Icon(Icons.local_fire_department),
            label: 'Hot Dishes',
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
