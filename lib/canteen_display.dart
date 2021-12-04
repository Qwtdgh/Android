part of 'main.dart';

class _CanteenInfo extends StatelessWidget {
  late CanteenInfo data;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute
        .of(context)!
        .settings
        .arguments as CanteenInfo;
    return Scaffold(
      appBar: AppBar(
        title: Text(data.canteenName),
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
        child: _CanteenInfoPage(data: data),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/canteen/cart');
        },
        child: const Icon(Icons.shopping_cart),
        backgroundColor: Colors.orangeAccent,
      ),*/
    );
  }
}

class _CanteenInfoPage extends StatelessWidget {
  final CanteenInfo data;

  const _CanteenInfoPage({
    Key? key,
    required this.data,
  }) : super(key: key);

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
                data.canteenImgUrl,
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
                  '食堂名称：\t' + data.canteenName,
                  style: textStyle,
                ),
                Text(
                  '食堂地址：\t' + data.canteenAddr,
                  style: textStyle,
                ),
                Text(
                  '食堂电话：\t' + data.canteenTel,
                  style: textStyle,
                ),
              ],
            ),
          ),
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
            _MenuRoot(),
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
                    Navigator.pushNamed(context, '/cart');
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
  _MenuRoot({Key? key}) : super(key: key);
  DishInfo dishInfo = const DishInfo(
    dishImgUrl:
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimgsa.baidu.com%2Fexp%2Fw%3D500%2Fsign%3D449be3d66381800a6ee5890e813433d6%2F8694a4c27d1ed21b9b3734bca26eddc450da3fe8.jpg&refer=http%3A%2F%2Fimgsa.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1640937777&t=f86139b4672f345a1a881cc08deb4aeb',
    dishName: '宫保鸡丁',
    dishPlace: '合一食堂',
    dishPrice: 30000,
    comments: [
      'Great',
      'Garbage',
      'Huge',
      'Huge',
      'Huge',
      'Huge',
      'Huge',
      'Huge',
      'Huge',
      'Huge',
      'Huge',
      'Huge',
      'Huge',
      'Huge',
      'Huge',
      'Huge',
      'Huge',
      'Huge',
      'Huge',
      'Huge'
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          return _MenuSuggestedDishCard(data: dishInfo);
        },
      ),
    );
  }
}

class _MenuSuggestedDishCard extends StatelessWidget {
  final DishInfo data;

  const _MenuSuggestedDishCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/canteen/dishdisplay', arguments: data);
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
            data.dishImgUrl,
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
        ],
      ),
    );
  }
}