part of 'main.dart';

class _DishInfo extends StatelessWidget {
  late var food;

  @override
  Widget build(BuildContext context) {
    food = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('DishInfo'),
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
        child: _DishInfoPage(food),
      ),
    );
  }
}

class _DishInfoPage extends StatelessWidget {
  late var food;
  var shopping_list = List.empty(growable: true);

  _DishInfoPage(this.food);

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
          renderDishInfo(), // Row
          renderStars(), // Star
          renderMyStars(), // My Stars
          renderAddToChart(), // Button
          renderComment(context), // ListView
        ],
      ),
    );
  }

  Widget renderDishInfo() {
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
              child: Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  Image.network(
                    food['foodUrl'],
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 100,
                    child: Container(
                        // padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        alignment: Alignment.bottomRight,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black54],
                          ),
                        ),
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
                  '名称：\t' + food['foodName'],
                  style: textStyle,
                ),
                Text(
                  '食堂：\t' + food['foodStoreName'],
                  style: textStyle,
                ),
                Text(
                  '价格：\t' + food['foodPrice'].toDouble().toStringAsFixed(2),
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget renderStars() {
    return Container(
      margin: const EdgeInsets.all(5),
      // constraints: const BoxConstraints.expand(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Ratings:',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SmoothStarRating(
              allowHalfRating: true,
              // onRated: (v) {},
              starCount: 5,
              rating: 3.5,
              size: 40.0,
              isReadOnly: true,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              color: Colors.yellow,
              borderColor: Colors.yellow,
              spacing: 0.0),
        ],
      ),
    );
  }

  Widget renderMyStars() {
    return Container(
      margin: const EdgeInsets.all(5),
      // constraints: const BoxConstraints.expand(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'My Rating:',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SmoothStarRating(
              allowHalfRating: true,
              onRated: (v) {},
              starCount: 5,
              rating: 3.5,
              size: 40.0,
              isReadOnly: false,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              color: Colors.grey,
              borderColor: Colors.grey,
              spacing: 0.0),
        ],
      ),
    );
  }

  Widget renderAddToChart() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
        constraints: const BoxConstraints(minHeight: 50, minWidth: 250),
        alignment: Alignment.bottomLeft,
        // padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: const Text(
          'Comments:',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      Container(
          constraints: const BoxConstraints(minHeight: 50, minWidth: 20),
          alignment: Alignment.topRight,
          margin: const EdgeInsets.all(1),
          child: ElevatedButton(
            child: const Icon(Icons.add_shopping_cart),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              primary: Colors.red,
              padding: const EdgeInsets.all(8),
              shadowColor: Colors.grey,
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.yellow,
              ),
            ),
            onPressed: () {
              shopping_list.add(food);
            },
          )),
    ]);
  }

  Widget renderComment(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          _CommentDisplay(comments: food['comments']),
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
                  Navigator.pushNamed(context, '/cart',
                      arguments: shopping_list);
                },
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentDisplay extends StatelessWidget {
  final List<String> comments;

  const _CommentDisplay({
    Key? key,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEFEFEF),
      child: SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return _CommentCard(comment: comments[index]);
          },
        ),
      ),
    );
  }
}

class _CommentCard extends StatelessWidget {
  final String comment;

  const _CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: Text(
        '"' + comment + '"',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}
