import 'package:ecommerce_user_app/Auth/AuhtService.dart';
import 'package:ecommerce_user_app/Pages/viewItemPage.dart';
import 'package:ecommerce_user_app/Provider/UserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../Utils/Colors.dart';

class RegisterSection extends StatefulWidget {
  final VoidCallback onSuccess ;
  final Function(String) onFailur;
  const RegisterSection({super.key,required this.onSuccess,required this.onFailur});

  @override
  State<RegisterSection> createState() => _RegisterSectionState();
}

class _RegisterSectionState extends State<RegisterSection> {
  final _nameController = TextEditingController();
  final _phoneControllerr = TextEditingController();
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
              controller: _nameController,

              decoration:const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                hintText: "your name"
              ),
              validator: (value){
                if(value == null || value.isEmpty)
                {
                  return "please enter valid name";
                }
                return null;
              } ,
            ),
            TextFormField(
              controller: _phoneControllerr,

              decoration:const InputDecoration(
                  prefixIcon: Icon(Icons.call),
                  hintText: "phone number"
              ),
              validator: (value){
                if(value == null || value.isEmpty)
                {
                  return "please enter valid phone NO.";
                }
                return null;
              } ,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration:const InputDecoration(
                  prefixIcon: Icon(Icons.email),
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
                onPressed: _registerAction,
                child:const Text("SIGN IN"),
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
  void _registerAction()async{
    if(_formKey.currentState!.validate()){
      EasyLoading.show(status: "please wait");

      final name = _nameController.text;
      final email =_emailController.text;
      final phoneNo = _phoneControllerr.text;
      final password =_passwordController.text;

      try{
        final user = await AuthService.register(email, password);
        await Provider.of<UserProvider>(context,listen: false).addUser(firbaseUser: user,name: name,phoneNo: phoneNo);
        EasyLoading.dismiss();
        widget.onSuccess();

      } on FirebaseAuthException catch(err){
        EasyLoading.dismiss();
        widget.onFailur(err.message!);
      }
    }
  }

  @override
  void dispose() {

    _nameController.dispose();
    _phoneControllerr.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
