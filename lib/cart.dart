part of main;

class _Shopping_Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var shoppingList = ModalRoute
        .of(context)!
        .settings
        .arguments as List<DishInfo>;
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
      body: Center(
        child: _CartBody(shoppingList),
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
  late List<DishInfo> shoppingList;
  _CartBody(this.shoppingList);

  @override
  Widget build(BuildContext context) {
    return _GuessYouLikePage(shoppingList);
  }
}

class _GuessYouLikePage extends StatefulWidget {
  late List<DishInfo> shoppingList;
  _GuessYouLikePage(this.shoppingList);

  @override
  _GuessYouLikePageState createState() => _GuessYouLikePageState(shoppingList);
}

class _GuessYouLikePageState extends State<_GuessYouLikePage> {
  late List<DishInfo> shoppingList;
  _GuessYouLikePageState(this.shoppingList);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: shoppingList.length,
      itemBuilder: (BuildContext context, int index) {
        return _shopping_card(shoppingList[index]);
      },
    );
  }
}

class _shopping_card extends StatelessWidget {
  late DishInfo shoppingDish;
  _shopping_card(this.shoppingDish);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(height: 25.0),
          getFoodItem(
            context,
              shoppingDish.dishName,
              shoppingDish.dishImgUrl,
              shoppingDish.dishPrice,
              shoppingDish.dishPlace,
              5),
          SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.only(left: 125.0),
            child: Container(height: 1.0, color: Colors.grey),
          ),
        ]
    );
  }

  Widget getFoodItem(BuildContext context, String dishName, String imgUrl, int price, String canteen,
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 125.0,
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

