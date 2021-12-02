part of 'main.dart';

class _DishInfo extends StatelessWidget {
  late DishInfo data;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as DishInfo;
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
        child: _DishInfoPage(data: data),
      ),
    );
  }
}

class _DishInfoPage extends StatelessWidget {
  final DishInfo data;

  const _DishInfoPage({
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
          renderDishInfo(), // Row
          renderStars(), // Star
          renderMyStars(), // My Stars
          renderAddToChart(), // Button
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
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
          renderComment(), // ListView
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
              child: Image.network(
                data.dishImgUrl,
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
                  '菜品名称:\t' + data.dishName,
                  style: textStyle,
                ),
                Text(
                  '食堂:\t\t\t\t\t\t\t\t' + data.dishPlace,
                  style: textStyle,
                ),
                Text(
                  '价格:\t\t\t\t\t\t\t\t' + data.dishPrice.toDouble().toStringAsFixed(2),
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
      margin: const EdgeInsets.all(10),
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
      margin: const EdgeInsets.all(10),
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
    return Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(10),
        // constraints: const BoxConstraints.expand(),
        child: ElevatedButton(

          child: const Text("下单"),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            padding: const EdgeInsets.all(8),
            shadowColor: Colors.grey,
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.yellow,
            ),
          ),
          onPressed: () {},
        ));
  }

  Widget renderComment() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: _CommentDisplay(comments: data.comments),
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
        height: 100,
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
