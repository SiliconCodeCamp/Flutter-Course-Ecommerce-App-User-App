
import 'package:ecommerce_user_app/DB/DbHelper.dart';
import 'package:flutter/cupertino.dart';

import '../Models/OrderModel.dart';

class orderProvider with ChangeNotifier{
  List<OrderModel> orderList= [];

  Future<void> saveOrder(OrderModel order) {
    return DbHelper.saveOrder(order);
  }
}