import 'package:ecommerce_user_app/Pages/viewItemPage.dart';
import 'package:ecommerce_user_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

import '../Auth/AuhtService.dart';

class Login_section extends StatefulWidget {
final VoidCallback onSuccess ;
final Function(String) onFailur;
const Login_section({super.key,required this.onFailur,required this.onSuccess});

  @override
  State<Login_section> createState() => _Login_sectionState();
}

class _Login_sectionState extends State<Login_section> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration:const InputDecoration(
                prefixIcon: Icon(Icons.email,),
                  hintText: "Email"
              ),
              validator: (value){
                if(value == null || value.isEmpty)
                {
                  return "please valid Email";
                }
                return null;
              } ,
            ),
            TextFormField(
              controller: _passwordController,
              decoration:const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Password"
              ),
              validator: (value){
                if(value == null || value.isEmpty || value.length < 8)
                {
                  return "please valid password";
                }
                return null;
              } ,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _loginAction,
                child:const Text("LOG IN"),
                style:ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(25,25,33,0.98),
                  foregroundColor: SurfaceWhite,

                ),
              ),
            )
          ],
        )
    );


  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Future<void> _loginAction() async {
    if(_formKey.currentState!.validate()){
      EasyLoading.show(status: "please wait");


      final email =_emailController.text;
      final password =_passwordController.text;

      try{
        final user = await AuthService.Login(email, password);
        EasyLoading.dismiss();
widget.onSuccess();
      } on FirebaseAuthException catch(err){
        print(err.message);
        EasyLoading.dismiss();
        widget.onFailur(err.message!);
      }
    }

  }
}
