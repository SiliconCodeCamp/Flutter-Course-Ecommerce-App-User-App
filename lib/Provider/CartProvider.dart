
import 'package:ecommerce_user_app/Auth/AuhtService.dart';
import 'package:ecommerce_user_app/DB/DbHelper.dart';
import 'package:ecommerce_user_app/Models/Items.dart';
import 'package:ecommerce_user_app/Utils/ItemsUtils.dart';
import 'package:flutter/foundation.dart';
import 'package:ecommerce_user_app/Models/CartModel.dart';

class cartProvider with ChangeNotifier{

  List<cartModel> cartList = [];

  int get totalAmountOfCart => cartList.length;

  bool isItemInCart (String id){
    bool tag = false;

    for(final cartItem in cartList ){

      if(cartItem.itemId == id){
        tag = true ;
        break;

      }
    }
    return tag;


  }

  getAllMyCart(){
    DbHelper.getAllMyCart(AuthService.currentUser!.uid).listen((snapshot) {
      cartList =List.generate(snapshot.docs.length,
              (index) => cartModel.fromJson(snapshot.docs[index].data()));
      notifyListeners();
    });

  }

  Future<void> addToCart(Item item){
    final CartModel = cartModel(
        itemId: item.id!,
        itemModel: item.model,
        price: priceAfterDiscount(item.price, item.discount),
        imageUrl: item.thumbnail.DownlaodUrl);

    return DbHelper.addToCart(CartModel, AuthService.currentUser!.uid);

  }


  Future<void> RemoveFromCart(String CartItemUID){
    return DbHelper.delete(CartItemUID, AuthService.currentUser!.uid);

  }
   void decreaseQuantity(cartModel model){

    if(model.quantity > 1){
      model.quantity -=1;
      DbHelper.updateCartQuantity(AuthService.currentUser!.uid, model);
    }

   }


   void increaseQuantity(cartModel model){
    model.quantity +=1 ;
    DbHelper.updateCartQuantity(AuthService.currentUser!.uid, model);
   }

   num PriceForAllQuantity(cartModel model)=> model.price * model.quantity;


  num getCartSubTotal(){

    num total = 0 ;
    for(final item in cartList){
      total += PriceForAllQuantity(item);
    }
    return total;
  }

 Future<void> clearCart()=> DbHelper.clearCart(AuthService.currentUser!.uid
     , cartList);

}