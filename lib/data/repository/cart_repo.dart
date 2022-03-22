
import 'dart:convert';

import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];

  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList){
    //sharedPreferences.remove(AppConstants.CART_LIST);
    //sharedPreferences.remove(AppConstants.CART_HISOTRY_LIST);
    var time = DateTime.now().toString();
    cart = [];

    //convert objects to string for sharedPreferences
    cartList.forEach((element){
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    //getCartList();
    
  }

  List<CartModel> getCartList(){

    List<String> carts = [];

    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("inside getCartList "+carts.toString());
    }

    List<CartModel> cartList = [];

    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });
    
    return cartList;
  }

  void addToCartHistoryList(){
    
    if(sharedPreferences.containsKey(AppConstants.CART_HISOTRY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISOTRY_LIST)!;
    }

    for(int i=0;i<cart.length; i++){
      // print("history list "+cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISOTRY_LIST, cartHistory);
    print("the length of history list is "+getCartHistoryList().length.toString());
    for(int j=0;j<getCartHistoryList().length;j++){
      print("the time for the order is "+getCartHistoryList()[j].time.toString());
    }
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISOTRY_LIST)){
      cartHistory=[];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISOTRY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    
    cartHistory.forEach((element)=> cartListHistory.add(CartModel.fromJson(jsonDecode(element))));

    return cartListHistory; 
  }

  void removeCart(){
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }


  /*  Map<String,int> cartItemsPerOrder = Map();
  
  for(int i=0; i<getCartHistoryList.length; i++){
    if(cartItemsPerOrder.containsKey(getCartHistoryList[i]["time"])){
      cartItemsPerOrder.update(getCartHistoryList[i]["time"],(value)=>++value);
    }else {
      cartItemsPerOrder.putIfAbsent(getCartHistoryList[i]["time"],()=>1);
    }
  }
  
  List<int> cartOrderTimeToList(){
    return cartItemsPerOrder.entries.map((e)=>e.value).toList();
  }
  
  List<int> orderTimes = cartOrderTimeToList(); */

}