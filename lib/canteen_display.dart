part of 'main.dart';

class _CanteenInfo extends StatelessWidget {
  late CanteenInfo data;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as CanteenInfo;
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
          renderDishInfo(), // Row
          // renderAddToChart(), // Button
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
}