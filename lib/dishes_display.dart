part of 'main.dart';

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => _Home_Root(),
        '/home/dishdisplay': (context, {arguments}) => _DishInfo(),
        // '/receive': (context) => const _Order_ReceiveRoute(),
        '/cart': (context) => _ShoppingCart(),
      },
    );
  }
}

class _Home_Root extends StatelessWidget {
  _Home_Root({Key? key}) : super(key: key);
  DishInfo dishInfo = const DishInfo(
    dishImgUrl:
        'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimgsa.baidu.com%2Fexp%2Fw%3D500%2Fsign%3D449be3d66381800a6ee5890e813433d6%2F8694a4c27d1ed21b9b3734bca26eddc450da3fe8.jpg&refer=http%3A%2F%2Fimgsa.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1640937777&t=f86139b4672f345a1a881cc08deb4aeb',
    dishName: '宫保鸡丁',
    dishPlace: '合一食堂',
    dishPrice: 30000,
    comments: ['Great', 'Garbage', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge', 'Huge'],
  );

  @override
  Widget build(BuildContext context) {
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
            itemBuilder: (context, index) {
              return _SuggestedDishCard(data: dishInfo);
            },
          ),
        ));
  }
}

class _SuggestedDishCard extends StatelessWidget {
  final DishInfo data;

  const _SuggestedDishCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/home/dishdisplay', arguments: data);
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
            renderCover(),
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
            data.dishPlace,
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

  Widget renderCover() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Image.network(
            data.dishImgUrl,
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
                data.dishName,
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
                        onPressed: () {},
                      )),
                )),
          ),
        ],
      ),
    );
  }
}

class DishInfo {
  // dish image
  final String dishImgUrl;

  // dish name
  final String dishName;

  // dish canteen
  final String dishPlace;

  // dish price
  final int dishPrice;

  // dish comments
  final List<String> comments;

  const DishInfo({
    required this.dishImgUrl,
    required this.dishName,
    required this.dishPlace,
    required this.dishPrice,
    required this.comments,
  });
}
