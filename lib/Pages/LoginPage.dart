import 'dart:math';

import 'package:ecommerce_user_app/Auth/AuhtService.dart';
import 'package:ecommerce_user_app/Pages/viewItemPage.dart';
import 'package:ecommerce_user_app/Provider/UserProvider.dart';
import 'package:ecommerce_user_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../CustomWidgets/Login_Section.dart';
import '../CustomWidgets/register_Section.dart';

enum AuthChoice { login, register }

class Loging_Page extends StatefulWidget {
  static const String routeName = "/login";
  const Loging_Page({super.key});
  @override
  State<Loging_Page> createState() => _Loging_PageState();
}

class _Loging_PageState extends State<Loging_Page> {
  String _errMsg = "";
  AuthChoice _authChoice = AuthChoice.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Weclome to AppName",
                style:TextStyle(fontSize: 35,color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SegmentedButton<AuthChoice>(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white;
                }
                return null;
              }), foregroundColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Color.fromRGBO(25,25,33,0.98);
                }
                return Colors.white;
              }), shape: MaterialStateProperty.resolveWith((states) {
                return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                );
              })),
              segments: [
                ButtonSegment<AuthChoice>(
                    value: AuthChoice.login, label: Text("LOGIN")),
                ButtonSegment<AuthChoice>(
                    value: AuthChoice.register, label: Text("Register",))
              ],
              selected: {_authChoice},
              showSelectedIcon: false,
              onSelectionChanged: (choice) {
                setState(() {
                  _authChoice = choice.first;
                });
              },
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 4,vertical:14 ),
            child: Container(

              decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 0,
                    blurRadius:0,
                    offset: Offset(1,1), // changes position of shadow
                  ),]

              ),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: AnimatedCrossFade(
                    duration: const Duration(microseconds: 400),
                    crossFadeState: _authChoice == AuthChoice.login
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: Login_section(
                      onFailur: (value) {
                        setState(() {
                          _errMsg = value;
                        });
                      },
                      onSuccess: () {
                        context.goNamed(viewItemPage.routeName);

                      },
                    ),
                    secondChild: RegisterSection(
                      onSuccess: () {
                        context.goNamed(viewItemPage.routeName);
                      },
                      onFailur: (value) {
                        setState(() {
                          _errMsg = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),),
            if (_errMsg.isNotEmpty)
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  _errMsg,
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "OR",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20,color: Colors.white),
              ),
            ),
            ElevatedButton.icon(
              onPressed: SignInWithGoogle,
              icon: Icon(Icons.g_mobiledata),
              label: Text("SIGN IN WITH GOOGLE"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  void SignInWithGoogle() async {
    final ceredential = await AuthService.signInWithGoogle();
    final exist = await Provider.of<UserProvider>(context, listen: false)
        .doesUserExist(ceredential.user!.uid);

    if (!exist) {
      EasyLoading.show(status: "Please wait ");
      await Provider.of<UserProvider>(context, listen: false).addUser(
          firbaseUser: ceredential.user!,
          name: ceredential.user!.displayName,
          phoneNo: ceredential.user!.phoneNumber);
    }

    EasyLoading.dismiss();

    context.goNamed(viewItemPage.routeName);
  }
}
