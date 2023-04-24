import 'package:flutter/material.dart';
import 'package:likeimage/model/item_model.dart';
import 'package:likeimage/providers/item_provider.dart';
import 'package:likeimage/widget/body_swiper.dart';
import 'package:provider/provider.dart';

enum filterOption { all, favorite }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isFavorite = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ItemProvider>(context , listen: false).readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: const Text(
            "Favorite Images",
          ),
          leading: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Consumer<ItemProvider>(
              builder: (context, item, child) {
                return Badge(
                  label: Text(
                    item.countItemFavorite.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    size: 26,
                  ),
                );
              },
            ),
          ),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  if (value == filterOption.all) {
                    isFavorite = false;
                  } else {
                    isFavorite = true;
                  }
                });
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: filterOption.all,
                  child: Text("Show all"),
                ),
                const PopupMenuItem(
                  value: filterOption.favorite,
                  child: Text("Favorite"),
                ),
              ],
            ),
          ],
        ),
        body: SwipeBody(
          isFavorite: isFavorite,
        ));
  }
}
