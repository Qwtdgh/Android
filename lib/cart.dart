part of main;

class _Shopping_Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
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
      body: const Center(
        child: _CartBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: const Icon(Icons.payment),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}

class _CartBody extends StatelessWidget {
  const _CartBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GuessYouLikePage();
  }
}

class _GuessYouLikePage extends StatefulWidget {
  @override
  _GuessYouLikePageState createState() => _GuessYouLikePageState();
}

class _GuessYouLikePageState extends State<_GuessYouLikePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 25.0),
        getFoodItem(
            'Chicken Chow Mein',
            'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimgsa.baidu.com%2Fexp%2Fw%3D500%2Fsign%3D449be3d66381800a6ee5890e813433d6%2F8694a4c27d1ed21b9b3734bca26eddc450da3fe8.jpg&refer=http%3A%2F%2Fimgsa.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1640937777&t=f86139b4672f345a1a881cc08deb4aeb',
            123,
            '合一食堂',
            5),
        SizedBox(height: 25.0),
        Padding(
          padding: const EdgeInsets.only(left: 125.0),
          child: Container(height: 1.0, color: Colors.grey),
        ),
        const SizedBox(height: 15.0),
        getFoodItem(
            'Beef vermicelli soup',
            'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimgsa.baidu.com%2Fexp%2Fw%3D500%2Fsign%3D449be3d66381800a6ee5890e813433d6%2F8694a4c27d1ed21b9b3734bca26eddc450da3fe8.jpg&refer=http%3A%2F%2Fimgsa.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1640937777&t=f86139b4672f345a1a881cc08deb4aeb',
            123,
            '合一食堂',
            4),
        const SizedBox(height: 25.0),
        Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: Container(
            height: 1.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  getFoodItem(String dishName, String imgUrl, int price, String canteen,
      int num) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 80.0,
              width: 80.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  image: DecorationImage(
                      image: NetworkImage(
                        imgUrl,
                      ),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width - 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          dishName,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                const SizedBox(height: 35.0),
                Row(
                  children: <Widget>[
                    const Icon(Icons.attach_money, color: Colors.grey),
                    Text(
                      price.toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 7.0),
                    const Icon(Icons.restaurant, color: Colors.grey),
                    Text(
                      canteen.toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 7.0),
                    const Icon(Icons.one_x_mobiledata, color: Colors.grey),
                    Text(
                      num.toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }
}
