// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:grubswipe/data/models/food_item/food_item.dart';
// import 'package:grubswipe/data/services/dashboard_service.dart';
// import 'package:rxdart/rxdart.dart';
// import '../../locator.dart';
//
// abstract class ABSCartViewModel extends ChangeNotifier {
//   List<FoodItemModel> _cartList = [];
//   List<FoodItemModel> get cartList => _cartList;
//   set setCartList(List<FoodItemModel> value);
//   clearCartList(FoodItemModel foodItem);
//
//   final _listController = BehaviorSubject<List<FoodItemModel>>.seeded([]);
//   Stream<List<FoodItemModel>> get listStream => _listController.stream;
//   set setOrderList(List<FoodItemModel> value);
//
//   num _totalAmounts = 0.0;
//   num get totalAmount => _totalAmounts;
//   set setTotalAmount(num value);
//
//   addAmount(double amount);
//   addToList(FoodItemModel orderItem);
//   removeFromList(FoodItemModel orderItem);
//
//   @override
//   void dispose() {
//     super.dispose();
//     _listController.close();
//   }
//
// }
//
// class CartViewModel extends ABSCartViewModel {
//   ABSDashboardService _dashboardService = locator<ABSDashboardService>();
//
//   CartViewModel();
//
//   set setCartList(List<FoodItemModel> value) {
//     _cartList = value;
//     notifyListeners();
//   }
//
//   set setOrderList(List<FoodItemModel> value) {
//     _listController.sink.add(value);
//     notifyListeners();
//   }
//
//   set setTotalAmount(num value) {
//     _totalAmounts = value;
//     notifyListeners();
//   }
//
//   clearCartList(FoodItemModel foodItem) {
//     // int index = _cartList.indexWhere((element) => element.id == foodItem.id);
//     // _cartList.removeAt(index);
//     //remove it from the list
//     _cartList.remove(foodItem);
//     notifyListeners();
//   }
//
//   addToList(FoodItemModel orderItem) {
//     _listController.sink.add(addOrderToList(orderItem));
//     notifyListeners();
//   }
//
//   addAmount(double amount) {
//     _totalAmounts = amount;
//     notifyListeners();
//   }
//
//   removeFromList(FoodItemModel orderItem) {
//     _listController.sink.add(removeOrderFromList(orderItem));
//     notifyListeners();
//   }
//
//   List<FoodItemModel> addOrderToList(FoodItemModel cartItem) {
//     bool isPresent = false;
//     cartItem.controlCart = true;
//     if (_cartList.length > 0) {
//       for (int i = 0; i < _cartList.length; i++) {
//         if (_cartList[i].id == cartItem.id) {
//           increaseItemQuantity(cartItem);
//           isPresent = true;
//           break;
//         } else {
//           isPresent = false;
//         }
//       }
//
//       if (!isPresent) {
//         _cartList.add(cartItem);
//       }
//     } else {
//       _cartList.add(cartItem);
//     }
//     return _cartList;
//   }
//
//   List<FoodItemModel> removeOrderFromList(FoodItemModel orderItem) {
//     if (orderItem.quantity > 1) {
//       //only decrease the quantity
//       decreaseItemQuantity(orderItem);
//     } else {
//       orderItem.controlCart = false;
//       //remove it from the list
//       _cartList.remove(orderItem);
//     }
//     return _cartList;
//   }
//
//   void increaseItemQuantity(FoodItemModel cartItem) => cartItem.incrementQuantity();
//   void decreaseItemQuantity(FoodItemModel cartItem) => cartItem.decrementQuantity();
//
// }
