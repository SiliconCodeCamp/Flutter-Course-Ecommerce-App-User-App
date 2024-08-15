import 'package:ecommerce_user_app/Models/Items.dart';
import 'package:ecommerce_user_app/Pages/ItemsDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import '../Utils/ItemsUtils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GridItemView extends StatelessWidget {
  final Item item;
  const GridItemView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed(itemDetailsPage.routeName,extra: item.id);
      },
      child: Container(
        color: Colors.white,
        child: Card(
          child: Stack(

            children: [
              Column(
                children: [
                  Expanded(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: item.thumbnail.DownlaodUrl,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, err) => const Icon(Icons.error,),
                      )),
                  Text(
                    item.model,
                    style: TextStyle(fontSize: 25,color: Colors.white),

                  ),
                  if (item.discount > 0)
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: RichText(
                        text: TextSpan(
                            text:
                            '\$${priceAfterDiscount(item.price, item.discount)}',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            children: [
                              TextSpan(
                                  text: '\$${item.price}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ))
                            ]),
                      ),
                    ),
                  if (item.discount == 0)
                    Padding(
                      padding: EdgeInsets.all(6),
                      child: Text(
                        "\$${item.price}",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.avgRating.toStringAsFixed(1)),
                        const SizedBox(
                          width: 5,
                        ),
                        RatingBar.builder(
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                          initialRating: item.avgRating.toDouble(),
                          minRating: 0.0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemSize: 22,
                          itemCount: 5,
                          itemPadding:
                          const EdgeInsets.symmetric(horizontal: 0.0),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
