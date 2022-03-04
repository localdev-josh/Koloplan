import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:koloplan/data/services/dashboard_service.dart';

import '../../locator.dart';

abstract class ABSDashboardViewModel extends ChangeNotifier {


  String email,
      password,
      phoneNumber,
      gender,
      verificationCode,
      pin,
      referralCode;

  int _swipeIndex = 0;
  int get swipeIndex => _swipeIndex;
  set setSwipeIndex(int value);

  bool _screenInHome = true;
  bool get screenInHome => _screenInHome;
  set setScreenInHome(bool value);

  bool _foodIsLiked = false;
  bool get foodIsLiked => _foodIsLiked;
  set setFoodIsLiked(bool value);


  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set setSelectedIndex(int value);

  VoidCallback _callback;
  VoidCallback get callback => _callback;
  set callback(VoidCallback value);

  /// Controls bottom progress loader
  bool _shouldReload = false;
  bool get shouldReload => _shouldReload;
  set setShouldReload(bool value);

  /// tracks the number of times the home icon is pressed
  int _taps = 1;
  int get taps => _taps;
  set setTap(int value);

  /// Controls bottom progress loader animation value
  double _progressValue;
  double get progressValue => _progressValue;
  set setProgressValue(double value);

  /// [_progressController] is the animation controller in charge of the bottom progress-bar
  AnimationController _progressController;
  AnimationController get progressController => _progressController;
  set setProgressLoader(AnimationController value);

  /// Control [Discover page] search-bar
  TextEditingController _searchController;
  TextEditingController get searchController => _searchController;
  set setSearchValue(String value);

  bool _miniLoading = false;
  bool get miniLoading => _miniLoading;
  set setMiniReload(bool value);

  bool _controlLoader = false;
  bool get controlLoader => _controlLoader;
  set setControlLoader(bool value);

  bool _isWriting = false;
  bool get isWriting => _isWriting;
  set setIsWriting(bool value);

  bool _trackSearchState = false;
  bool get trackSearchState => _trackSearchState;
  set setTrackSearchState(bool value);

  String _currentSearch = "";
  String get currentSearch => _currentSearch;
  set setCurrentSearch(String value);

  // List<SearchActivityItem> _searchList = List<SearchActivityItem>();
  // List<SearchActivityItem> get searchList => _searchList;
  // set setSearchList(List<SearchActivityItem> value);
  //
  // Future<Result<void>> sendUserSearch();
  // Future<Result<void>> fetchUserSearch();
  // Future<Result<void>> deleteUserSearch(int id);
  Future<bool> saveFoodToLocalDB();

  @override
  void dispose() {
    super.dispose();
    _progressController.dispose();
    _searchController.dispose();
  }
}

class DashboardViewModel extends ABSDashboardViewModel {
  ABSDashboardService _dashboardService = locator<ABSDashboardService>();

  DashboardViewModel() {
    _searchController = TextEditingController();
  }

  set setSwipeIndex(int value) {
    _swipeIndex = value;
    notifyListeners();
  }

  set setFoodIsLiked(bool value) {
    _foodIsLiked = value;
    notifyListeners();
  }

  set setScreenInHome(bool value) {
    _screenInHome = value;
    notifyListeners();
  }

  set setSelectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  set setTrackSearchState(bool value) {
    _trackSearchState = value;
    notifyListeners();
  }

  set setIsWriting(bool value) {
    _isWriting = value;
    notifyListeners();
  }

  set callback(VoidCallback value) {
    _callback = value;
    notifyListeners();
  }

  set setShouldReload(bool value) {
    _shouldReload = value;
    notifyListeners();
  }

  set setTap(int value) {
    _taps = value;
    notifyListeners();
  }

  set setProgressValue(double value) {
    _progressValue = value;
    notifyListeners();
  }

  set setProgressLoader(AnimationController value) {
    _progressController = value;
    notifyListeners();
  }

  set setSearchValue(String value) {
    _searchController.text = value;
    notifyListeners();
  }

  set setMiniReload(bool value) {
    _miniLoading = value;
    notifyListeners();
  }

  set setControlLoader(bool value) {
    _controlLoader = value;
    notifyListeners();
  }

  set setCurrentSearch(String value) {
    _currentSearch = value;
    notifyListeners();
  }

  // set setSearchList(List<SearchActivityItem> value) {
  //   _searchList = value;
  //   notifyListeners();
  // }

  Future<bool> saveFoodToLocalDB() async{
    /// Write local DB logic here
    _foodIsLiked = !_foodIsLiked;
    notifyListeners();
    print("Food is liked $_foodIsLiked");
    if (_foodIsLiked){
      return true;
    } else {
      return false;
    }
  }

  // @override
  // Future<Result<void>> sendUserSearch() async {
  //   print("Search outside $_currentSearch");
  //   /// Add search to local database
  //   await UserSearchDatabaseProvider.db.getSavedSearches().then((value) async {
  //     if(value.isNotEmpty) {
  //       print("Search not empty $_currentSearch");
  //       print("Search not empty lowercase ${_currentSearch.toLowerCase()}");
  //       var searchIsContained = value.where((element) => element.user_search.toString().toLowerCase() == _currentSearch.toLowerCase());
  //       if (searchIsContained.isEmpty) {
  //         UserSearchDatabaseProvider.db.insert(SearchActivityItem(user_search: _currentSearch)).whenComplete(() async {
  //           await fetchUserSearch();
  //         });
  //       }
  //     } else {
  //       print("Search empty $_currentSearch");
  //       print("Search empty lowercase ${_currentSearch.toLowerCase()}");
  //       UserSearchDatabaseProvider.db.insert(SearchActivityItem(user_search: _currentSearch)).whenComplete(() async {
  //         await fetchUserSearch();
  //       });
  //     }
  //   });
  //
  //   /// Connect to a backend and use [_dashboardService] service
  //   // var result = await _dashboardService.sendUserSearch(userSearch: _currentSearch);
  //   // if(result.error == false) {}
  //   // else {}
  //   // return result;
  //   return null;
  // }
  //
  // @override
  // Future<Result<void>> fetchUserSearch() async {
  //   await UserSearchDatabaseProvider.db.getSavedSearches().then((value) async {
  //     for(var item in value) {
  //       print("New search item ${item.user_search}");
  //     }
  //     print("List length is ${value.length}");
  //     setSearchList = value;
  //   });
  //   return null;
  // }
  //
  // @override
  // Future<Result<void>> deleteUserSearch(int id) async {
  //   await UserSearchDatabaseProvider.db.delete(id).then((value) async {
  //     fetchUserSearch();
  //   });
  //   return null;
  // }


}
