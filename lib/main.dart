import 'package:ecommerce_user_app/Auth/AuhtService.dart';
import 'package:ecommerce_user_app/Pages/CartPage.dart';
import 'package:ecommerce_user_app/Pages/CheckOurtPage.dart';
import 'package:ecommerce_user_app/Pages/ItemsDetailsPage.dart';
import 'package:ecommerce_user_app/Pages/viewItemPage.dart';
import 'package:ecommerce_user_app/Provider/CartProvider.dart';
import 'package:ecommerce_user_app/Provider/Item_Provider.dart';
import 'package:ecommerce_user_app/Provider/OrderProvider.dart';
import 'package:ecommerce_user_app/Provider/UserProvider.dart';
import 'package:ecommerce_user_app/Utils/Colors.dart';
import 'package:ecommerce_user_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Pages/LoginPage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (contex) => UserProvider()),
    ChangeNotifierProvider(create: (contex) => itemProvider()),
    ChangeNotifierProvider(create: (contex) => cartProvider()),
    ChangeNotifierProvider(create: (contex) => orderProvider()),
  ],
    child: MyApp(),

  ));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
   List<Color> colors = [Colors.blue, Colors.amber, Colors.pink];
  ThemeData _buildTheme(){
    final ThemeData base = ThemeData(
        scaffoldBackgroundColor:Color.fromRGBO(25,25,33,0.98));
    return base.copyWith(
      colorScheme:  base.colorScheme.copyWith(
        primary: Color.fromRGBO(82,93,111,0.3),
        onPrimary: Colors.white,
        secondary:Colors.white,
        error: ShrineErrorRed,
      ),
      textTheme: _buileTextTheme(GoogleFonts.ralewayTextTheme()),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Pink100,
      )
    );
  }



  TextTheme _buileTextTheme(TextTheme textTheme){
    return textTheme.copyWith(
      headlineSmall: textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w500,

      ),
        titleLarge: textTheme.titleLarge!.copyWith(
        fontSize: 19.0,

    ),
      bodySmall: textTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 15.0,

      ),
      bodyLarge: textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 17.0,


      ),

    ).apply(
      displayColor:Brown900,
      bodyColor: Brown900,
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'User app',
      builder: EasyLoading.init(),
      theme: _buildTheme(),
      routerConfig: _router,
    );
  }

  final _router = GoRouter(

    initialLocation: viewItemPage.routeName,
      redirect: (context,state){
      if(AuthService.currentUser == null){
        return Loging_Page.routeName;
      }

      return null;

      },

      routes: [

        GoRoute(
          name: Loging_Page.routeName,
            path: Loging_Page.routeName,
           builder:(context,state)=> const Loging_Page()
        ),
        GoRoute(
            name: viewItemPage.routeName,
            path: viewItemPage.routeName,
            builder:(context,state)=> const viewItemPage(),
          routes: [
            GoRoute(
                name: itemDetailsPage.routeName,
                path: itemDetailsPage.routeName,
                builder:(context,state)=> itemDetailsPage(id: state.extra! as String)
            ),
            GoRoute(
                name: cartpage.routeName,
                path: cartpage.routeName,
                builder:(context,state)=>const cartpage(),
              routes: [
                GoRoute(
                  name: checkOutPage.routeName,
                  path: checkOutPage.routeName,
                  builder:(context,state)=>const checkOutPage(),
                ),
              ]
            ),
          ]
        )

      ]);
}