import 'package:flutter/material.dart';

typedef routeCallback = Function(String newRoute);
class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  String previousRouteHere;
  final routeCallback onChanged;
  MyRouteObserver({this.onChanged});
  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;
    print('screenName $screenName');
    this.onChanged("$screenName");
    // if(screenName != previousRouteHere) {
    //   this.onChanged("$route", true);
    // } else {
    //   this.onChanged("$route", false);
    // }
    // do something with it, ie. send it to your analytics service collector
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    // previousRouteHere = previousRoute.settings.name;
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
      // this.onChanged("$route", true);
      print('screenName push $route');
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    // print("Replaced");
    // previousRouteHere = oldRoute.settings.name;
    // print("Replaced name ${oldRoute.settings.name}");
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
      // this.onChanged("$newRoute", true);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    // print("Popped");
    // String previousRouteHeree = route.settings.name;
    // // previousRouteHere = previousRoute.settings.name;
    // print("Popped name $previousRouteHeree");
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
      // this.onChanged("$previousRoute", true);
    }
  }
}