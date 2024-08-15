

import 'dart:io';


import 'package:ecommerce_user_app/Models/RatingModel.dart';
import 'package:ecommerce_user_app/Models/User.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../DB/DbHelper.dart';
import '../Models/Brand_Model.dart';
import '../Models/Items.dart';
import '../Models/image_Model.dart';

class itemProvider with ChangeNotifier {

  List<Brand> BrandList = [];
  List<Item> ItemsList = [];


  getAllBrands(){
    DbHelper.getAllBrands().listen((snapshot) {
      BrandList = List.generate(snapshot.docs.length, (index) => Brand.fromJson(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllItems(){
    DbHelper.getAllItems().listen((snapshot) {
     ItemsList = List.generate(snapshot.docs.length, (index) => Item.fromJson(snapshot.docs[index].data()));
      notifyListeners();
    });
  }



  Item FindItemsWithID(String id) =>
  ItemsList.firstWhere((element) => element.id == id);

  Future<void> addRating(String id,user appUser , num rating)async{
    final RatingModel = ratingModel(appuser: appUser, rating: rating);
    await DbHelper.addRating(id,RatingModel);

    final snapshot = await DbHelper.getAllRating(id);
    final List<ratingModel> ratingList =
    List.generate(snapshot.docs.length,
            (index) => ratingModel.fromJson(snapshot.docs[index].data()));

    num totalRating = 0 ;

    for( final rateItem in ratingList){
      totalRating += rateItem.rating;
    }

    final averageRating = totalRating / ratingList.length;
    return DbHelper.updateItem(id, {'avgRating':averageRating});
  }








}