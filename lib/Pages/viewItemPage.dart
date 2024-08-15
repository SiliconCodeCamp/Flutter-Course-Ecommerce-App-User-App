import 'package:ecommerce_user_app/Auth/AuhtService.dart';
import 'package:ecommerce_user_app/Pages/LoginPage.dart';
import 'package:ecommerce_user_app/Provider/CartProvider.dart';
import 'package:ecommerce_user_app/Provider/Item_Provider.dart';
import 'package:ecommerce_user_app/Provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../CustomWidgets/GridItemView.dart';
import '../CustomWidgets/Home_Page_Drawer.dart';

class viewItemPage extends StatefulWidget {
  static const routeName ="/Home";
  const viewItemPage({super.key});

  @override
  State<viewItemPage> createState() => _viewItemPageState();
}

class _viewItemPageState extends State<viewItemPage> {

  @override
  void didChangeDependencies() {
  Provider.of<itemProvider>(context,listen: false).getAllItems();
  Provider.of<itemProvider>(context,listen: false).getAllBrands();
  Provider.of<cartProvider>(context,listen: false).getAllMyCart();
  Provider.of<UserProvider>(context,listen: false).getUserInfo();
  super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.amber,
      width: 100,
      child: Scaffold(
        drawer:homePageDrawer(),
        appBar: AppBar(
          title: const Text("View item Page"),
          actions: [],
        ),body: Consumer<itemProvider>(
        builder: (context,provider,child)=>GridView.builder(
          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7),
          itemCount: provider.ItemsList.length,
          itemBuilder: (context,index){
            final item = provider.ItemsList[index];
            return Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
              decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(0,0), // changes position of shadow
                ),]

              ),
              child: GridItemView(item: item,),
            );
          },
        ),
      ),

      ),
    );
  }
}
