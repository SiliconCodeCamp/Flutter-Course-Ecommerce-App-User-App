import 'package:ecommerce_user_app/Pages/CheckOurtPage.dart';
import 'package:ecommerce_user_app/Provider/CartProvider.dart';
import 'package:ecommerce_user_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../CustomWidgets/CartItemView.dart';

class cartpage extends StatefulWidget {
  static const String routeName="CartPage";
  const cartpage({super.key});

  @override
  State<cartpage> createState() => _cartpageState();
}

class _cartpageState extends State<cartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("My Cart"),
      ),
      body: Consumer<cartProvider>(
        builder: (context,provider,child)=>Column(
          children: [
            Expanded(child: ListView.builder(
              itemCount: provider.cartList.length,
                itemBuilder: (context,index){
                  final model = provider.cartList[index];
                  return Padding(
                    padding: EdgeInsets.all(15)
                  ,child:  Container(
                      decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(0,0), // changes position of shadow
                          ),]

                      ),
                      child: CartItemView(model:model,provider:provider),
                    ),);
                })),
           Container(
             padding: EdgeInsets.all(4),

             decoration: BoxDecoration(
                 color:Colors.white,
                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
                 boxShadow: [BoxShadow(
                   color: Colors.grey.withOpacity(0.9),
                   spreadRadius: 4,
                   blurRadius: 5,
                   offset: Offset(0,0), // changes position of shadow
                 ),]

             ),
             child:  Card(
               child: Padding(
                 padding: EdgeInsets.all(10),
                 child: Row(
                   children: [
                     Expanded(
                         child: Text("Sub Total \$${provider.getCartSubTotal()}",style: Theme.of(context).textTheme.titleLarge,))
                     ,
                     OutlinedButton(onPressed:provider.totalAmountOfCart == 0 ? null : (){
                       context.goNamed(checkOutPage.routeName);
                     }
                         , child: Text("CHECKOUT"
                           ,style: TextStyle(color: Brown900,fontWeight: FontWeight.bold),))

                   ],
                 ),
               ),
             ),
           )
          ],
        ),
      ),
    );
  }
}
