import 'package:ecommerce_user_app/Pages/CartPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Auth/AuhtService.dart';
import '../Pages/LoginPage.dart';

class homePageDrawer extends StatelessWidget {
  const homePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            height: 150,
          ),
          ListTile(
            onTap:(){

            } ,
            leading: Icon(Icons.person),
            trailing: Text("My account"),
          ),
          ListTile(
            onTap:(){
              context.pop();
             context.goNamed(cartpage.routeName);
            } ,
            leading: Icon(Icons.shopping_cart),
            trailing: Text("My Cart"),
          ),
          ListTile(
            onTap:(){

            } ,
            leading: Icon(Icons.monetization_on),
            trailing: Text("My Orders"),
          ),
          ListTile(
            onTap:(){
              AuthService.Logout().then((value) =>context.goNamed(Loging_Page.routeName));

            } ,
            leading: Icon(Icons.logout),
            trailing: Text("My SignOut"),
          ),

        ],
      ),
    );
  }
}
