import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_app/Models/OrderModel.dart';
import 'package:ecommerce_user_app/Models/RatingModel.dart';

import '../Models/CartModel.dart';
import '../Models/User.dart';

class DbHelper{
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static const String collectionUser = "Users";
  static const String collectionBrands = "Brands";
  static const String collectionItem ="Items";
  static const String collectionCart ="My Cart";
  static const String collectionOrder ="orders";
  static const String collectionRating ="Ratings";
  static Future<void> addUser(user usr){
    return _db.collection(collectionUser).doc(usr.uid).set(usr.toJson());
  }

  static userExist(String uid) async {

    final snapShot = await _db.collection(collectionUser).doc(uid).get();

    return snapShot.exists;

  }


  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllBrands() =>
      _db.collection("Brands").snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllMyCart(String Uid) =>
      _db.collection(collectionUser)
          .doc(Uid)
          .collection(collectionCart)
          .snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllItems() =>
      _db.collection("Items").snapshots();

  static Future<void>addToCart(cartModel CartModel , String uid){

    return _db
        .collection(collectionUser)
        .doc(uid)
        .collection(collectionCart)
        .doc(CartModel.itemId)
        .set(CartModel.toJson());
  }

  static Future<void>delete(String cartitemId , String uid){

    return _db
        .collection(collectionUser)
        .doc(uid)
        .collection(collectionCart)
        .doc(cartitemId)
        .delete();
  }

  static Future<void> updateCartQuantity( String uid, cartModel model) {
    return _db.collection(collectionUser)
        .doc(uid)
        .collection(collectionCart)
        .doc(model.itemId)
      .set(model.toJson());


  }

  static Stream<DocumentSnapshot<Map<String,dynamic>>> getUserInfo(String uid) =>
      _db.collection(collectionUser).doc(uid).snapshots();

  static Future<void> saveOrder(OrderModel order) async{

    // // Save Order
   final wb =_db.batch();
    final orderDoc = _db.collection(collectionOrder).doc(order.orderId);
    wb.set(orderDoc, order.toJson());

     //calculate remaining item in stock

    for(final CartModel in order.itemsDetails){
      final itemSanp = await _db.collection(collectionItem)
          .doc(CartModel.itemId).get();
      final prevStock = itemSanp.data()!["inStock"];
      final itemDoc =_db.collection(collectionItem).doc(CartModel.itemId);
      wb.update(itemDoc, {'inStock': prevStock - CartModel.quantity});

    }


    // Update user info

    final userDoc = _db.collection(collectionUser).doc(order.appuser.uid);
    wb.set(userDoc, order.appuser.toJson());


    return wb.commit();

  }

  static Future<void> clearCart(String uid,List<cartModel> cartList){
    final wb = _db.batch();
    for(final cartItem in cartList ){
      final doc = _db.collection(collectionUser)
          .doc(uid)
          .collection(collectionCart)
          .doc(cartItem.itemId);

      wb.delete(doc);
    }

    return wb.commit();

  }

  static Future<void>addRating(String id, ratingModel RatingModel) {
    return _db.collection(collectionItem)
        .doc(id)
        .collection(collectionRating)
        .doc(RatingModel.appuser.uid)
        .set(RatingModel.toJson());

  }

  static Future<QuerySnapshot<Map<String,dynamic>>> getAllRating(String id){
    return _db.collection(collectionItem).doc(id)
        .collection(collectionRating).get();
  }

  static Future<void> updateItem(String id, Map<String,dynamic> map){
    return _db.collection(collectionItem).doc(id).update(map);
  }


}
