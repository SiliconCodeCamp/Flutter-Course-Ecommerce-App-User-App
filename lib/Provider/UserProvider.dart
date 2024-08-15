

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_app/Auth/AuhtService.dart';
import 'package:ecommerce_user_app/DB/DbHelper.dart';
import 'package:ecommerce_user_app/Models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {

  user? appUser;
  Future<void> addUser({required User firbaseUser,String? name , String? phoneNo}){
    final Appuser = user(uid: firbaseUser.uid, email: firbaseUser.email!,name:name
        ,phoneNo:phoneNo
        ,userJoinDate:Timestamp.fromDate(firbaseUser.metadata.creationTime!),
    );
    return DbHelper.addUser(Appuser);
  }

  doesUserExist(String uid) {
    return DbHelper.userExist(uid);
  }

  getUserInfo(){
    DbHelper.getUserInfo(AuthService.currentUser!.uid).listen((event) {
      if(event.exists){
        appUser = user.fromJson(event.data()!);
        notifyListeners();
      }
    });
  }


}