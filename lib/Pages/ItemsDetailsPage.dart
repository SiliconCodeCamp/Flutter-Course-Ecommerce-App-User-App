import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_user_app/Models/Items.dart';
import 'package:ecommerce_user_app/Provider/CartProvider.dart';
import 'package:ecommerce_user_app/Provider/Item_Provider.dart';
import 'package:ecommerce_user_app/Provider/UserProvider.dart';
import 'package:ecommerce_user_app/Utils/Colors.dart';
import 'package:ecommerce_user_app/Utils/ItemsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class itemDetailsPage extends StatefulWidget {
  static const String routeName = "detailsPage";
  final String id;
  const itemDetailsPage({super.key, required this.id});

  @override
  State<itemDetailsPage> createState() => _itemDetailsPageState();
}

class _itemDetailsPageState extends State<itemDetailsPage> {
  late Item item;
  late itemProvider provider;
  double userRating = 0.0;

  @override
  void didChangeDependencies() {
    provider = Provider.of<itemProvider>(context);
    item = provider.FindItemsWithID(widget.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.model,
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
              width: double.infinity,
              height: 180,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, err) => const Icon(Icons.error),
              imageUrl: item.thumbnail.DownlaodUrl),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Consumer<cartProvider>(
              builder: (context, provider, child) {
                bool isInCart = provider.isItemInCart(item.id!);
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 5,
                            blurRadius: 2,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ]),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (isInCart) {
                          provider.RemoveFromCart(item.id!);
                        } else {
                          provider.addToCart(item);
                        }
                      },
                      icon: Icon(isInCart
                          ? Icons.remove_shopping_cart
                          : Icons.shopping_cart),
                      label:
                          Text(isInCart ? "Remove From Cart" : 'Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: Text(
                'sale Price:\$${priceAfterDiscount(item.price, item.discount)}',style: TextStyle(color: Colors.white)),
            subtitle: Text('in Stock : ${item.inStock}',style: TextStyle(color: Colors.white),),
          ),
          Container(
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ]),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    RatingBar.builder(
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (value) {
                        userRating = value;
                      },
                      initialRating: userRating,
                      minRating: 0.0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          _rateThisProduct();
                        },
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(color: Brown900),
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _rateThisProduct() async {
    EasyLoading.show(status: "please wait");

    final appUser = Provider.of<UserProvider>(context, listen: false).appUser;

    await provider.addRating(item.id!, appUser!, userRating);

    EasyLoading.dismiss();

    showMsg(context, "rating succeed");
  }
}
