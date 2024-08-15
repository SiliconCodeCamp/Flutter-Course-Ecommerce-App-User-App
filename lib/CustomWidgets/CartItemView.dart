import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_user_app/Models/CartModel.dart';
import 'package:ecommerce_user_app/Provider/CartProvider.dart';
import 'package:flutter/material.dart';

class CartItemView extends StatelessWidget {

  final cartModel model ;
  final cartProvider provider;
  const CartItemView({super.key,required this.model,required this.provider});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              leading: CachedNetworkImage(
                width: 80,
                height: 80,
                imageUrl: model.imageUrl,
                placeholder: (context,url)=>
                const CircularProgressIndicator(),
                errorWidget: (context,url,err)=>
                Icon(Icons.error),
              ),
              title: Text(model.itemModel),
              subtitle: Text("UnitPrice : \$${model.price}"),
              trailing:  IconButton(onPressed: (){
                provider.RemoveFromCart(model.itemId);

              },icon: Icon(Icons.delete),),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: (){
                      provider.decreaseQuantity(model);
                    },
                    icon: Icon(Icons.remove_circle,size: 30,)),
                Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                  child:Text("${model.quantity}") ,),
                IconButton(
                    onPressed: (){
                      provider.increaseQuantity(model);
                    }
                    , icon: Icon(Icons.add_circle,size: 30,)),
                const Spacer(),
                Text("\$${provider.PriceForAllQuantity(model)}",style: Theme.of(context).textTheme.titleLarge,)
,              ],
            )
          ],
        ),
      ),
    );
  }
}
