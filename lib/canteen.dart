part of 'main.dart';

class _CanteenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/canteen',
      routes: {
        '/canteen': (context) => _CanteenRoot(),
        '/canteen/canteendisplay': (context, {arguments}) => _CanteenInfo(),
        '/canteen/dishdisplay': (context, {arguments}) => _DishInfo(),
        '/cart': (context) => _ShoppingCart(),
        // '/receive': (context) => const _Order_ReceiveRoute(),
      },
    );
  }
}

class _CanteenRoot extends StatefulWidget {
  @override
  _CanteenRootState createState() => _CanteenRootState();
}

class _CanteenRootState extends State<_CanteenRoot> {
  var stores = [];

  getAll(BuildContext context) async {
    var baseUrl = "http://42.192.60.125";
    var uri = "/api/getStores/";
    var body = {};
    http.Response response = await http.post(Uri.parse(baseUrl + uri), body: Convert.jsonEncode(body));
    final statusCode = response.statusCode;
    final responseBody = response.body;
    var result = Convert.jsonDecode(responseBody);
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
              return _CanteenCard(stores[index]);
            },
          ),
        ));
  }
}

class _CanteenCard extends StatelessWidget {
  var store;

  _CanteenCard(this.store);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/canteen/canteendisplay',
            arguments: store);
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
