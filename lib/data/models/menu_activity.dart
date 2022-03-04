import 'package:flutter/foundation.dart';

MenuList menuItemList = MenuList(menuItems: [
  MenuItemModel(
      title: "Account",
      icon: "edit_profile",
  ),
  MenuItemModel(
      title: "FAQ",
    icon: "chat_bubble"
  ),
  MenuItemModel(
      title: "Invite friends",
    icon: "invite_friend"
  ),
]);

class MenuList {
  List<MenuItemModel> menuItems;

  MenuList({@required this.menuItems});
}

class MenuItemModel {
  String title;
  String icon;

  MenuItemModel({
    this.title,
    this.icon,
  });
}



