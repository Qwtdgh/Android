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
        '/': (context) => _Canteen_Root(),
        '/canteendisplay': (context, {arguments}) => _CanteenInfo(),
        // '/receive': (context) => const _Order_ReceiveRoute(),
      },
    );
  }
}

class _Canteen_Root extends StatelessWidget {
  _Canteen_Root({Key? key}) : super(key: key);
  CanteenInfo canteenInfo = const CanteenInfo(
    canteenImgUrl:
    'https://img1.baidu.com/it/u=2263776819,1940511170&fm=26&fmt=auto',
    canteenName: '合一食堂',
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
              return _CanteenCard(data: canteenInfo);
            },
          ),
        ));
  }
}

class _CanteenCard extends StatelessWidget {
  final CanteenInfo data;

  const _CanteenCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/canteendisplay', arguments: data);
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
            data.canteenImgUrl,
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
                data.canteenName,
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

class CanteenInfo {
  // dish image
  final String canteenImgUrl;

  // dish name
  final String canteenName;

  // dish comments
  final List<String> comments;

  const CanteenInfo({
    required this.canteenImgUrl,
    required this.canteenName,
    required this.comments,
  });
}
