import 'package:flutter/material.dart';
import 'package:flutter_swipe/flutter_swipe.dart';
import 'package:likeimage/model/item_model.dart';
import 'package:likeimage/providers/item_provider.dart';
import 'package:provider/provider.dart';

class SwipeBody extends StatelessWidget {
  const SwipeBody({
    required this.isFavorite,
    super.key,
  });

  final isFavorite;

  @override
  Widget build(BuildContext context) {
    final dataItem = Provider.of<ItemProvider>(context);
    final items = isFavorite ? dataItem.showItemFavorite() : dataItem.items;

    return items.isNotEmpty
        ? Swiper(
            //neu su dung stack thi phai set width vs height cho thuoc tinh ben trong
            layout: SwiperLayout.STACK,
            itemWidth: 350.0,
            itemHeight: 650.0,
            scrollDirection: Axis.vertical,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ChangeNotifierProvider.value(
                value: items[index],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.white12,
                      title: Consumer<Item>(
                        builder: (context, item, child) {
                          return InkWell(
                            onTap: () {
                              item.toggleIsFavorite();
                              Provider.of<ItemProvider>(context, listen: false)
                                  .handleCountItem();
                            },
                            child: Icon(
                              Icons.favorite,
                              size: 30.0,
                              color:
                                  item.isFavorite ? Colors.red : Colors.white,
                            ),
                          );
                        },
                      ),
                      subtitle: const Text("Like images"),
                      trailing: Text(
                        items[index].name,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Image.asset(
                      items[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          )
        : Container(
          child: const Center(
              child: Text(
                "No Image",
              ),
            ),
        );
  }
}
