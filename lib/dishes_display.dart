part of 'main.dart';

class _HomePage extends StatelessWidget {
  late var userID;
  _HomePage(this.userID);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => _HomeRoot(userID),
        '/home/dishdisplay': (context, {arguments}) => _DishInfo(),
        // '/receive': (context) => const _Order_ReceiveRoute(),
        '/cart': (context) => _ShoppingCart(),
      },
    );
  }
}

class _HomeRoot extends StatefulWidget {
  late var userID;
  _HomeRoot(this.userID);

  @override
  _HomeRootState createState() => _HomeRootState(userID);
}

class _HomeRootState extends State<_HomeRoot> {
  var topFoodList = [];
  late var userID;
  _HomeRootState(this.userID);
  getAll(BuildContext context) async {
    var baseUrl = "http://42.192.60.125";
    var uri = "/api/getTopFoodList/";
    var body = {};
    http.Response response = await http.post(Uri.parse(baseUrl + uri), body: Convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    var result = Convert.jsonDecode(responseBody);
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
              return _SuggestedDishCard(topFoodList[index], userID);
            },
          ),
        ));
  }
}

class _SuggestedDishCard extends StatelessWidget {
  late var userID;
  late var topFood;

  _SuggestedDishCard(this.topFood, this.userID);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/home/dishdisplay', arguments: topFood);
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
                child: Container(
                  padding: const EdgeInsets.only(left: 5.0),
                  height: 40.0,
                  width: 40.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                    ),
                    color: Color(0xFFF76765),
                  ),
                  child: Center(
                      child: TextButton(
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setAll(context);
                    },
                  )),
                )),
          ),
        ],
      ),
    );
  }

  setAll(BuildContext context) async {
    var baseUrl = "http://42.192.60.125";
    var uri = "/api/setStar/";
    var body = {
      'userID': userID,
      'foodID': topFood['foodID'],
    };
    http.Response response = await http.post(Uri.parse(baseUrl + uri), body: Convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
  }
}