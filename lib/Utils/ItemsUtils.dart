import 'package:ecommerce_user_app/Models/image_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract final class itemUtils {

  static const List<String> itemsType = ["Silk","cotton", "polyster" ,"linen",
    "Satin","chifron"];

  static const List<String> itemsModels = ["shirt","T-Shirt", "Blouse" ,"Hoodie",
    "polotShirt","trouser","short"];
}

num priceAfterDiscount(num price , num discount) {
  return price-(price*discount/100);
}

List<Map<String,dynamic>> toImageList(List<imageModel> images){
  return List.generate(images.length, (index) => images[index].toJson());

}

showMsg(BuildContext context , String Msg){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(Msg)));
}

getForrmattedDate(DateTime dt ,{String pattern ='dd/MM/yyyy'}) =>
    DateFormat(pattern).format(dt);

String get makeOrderId =>
    "abc_${getForrmattedDate(DateTime.now(),pattern: 'yyyMMdd_HH:mm:ss')}";
