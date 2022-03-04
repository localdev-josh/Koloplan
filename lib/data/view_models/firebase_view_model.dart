import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:koloplan/data/local_database/user_local.dart';
import 'package:koloplan/data/models/individual/secondary_state.dart';
import 'package:koloplan/data/models/individual/user_data.dart';
import 'package:koloplan/data/models/result.dart';
import 'package:koloplan/data/services/firebase_service.dart';
import '../../locator.dart';

abstract class ABSFirebaseViewModel extends ChangeNotifier {
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String phoneNumber = "";
  String pin = "";
  String referralCode = "";

  UserData _user;
  UserData get user => _user;
  set user(UserData value);

  Future<Result<void>> loginCustomerWithEmail({String email, String password});
  Future<Result<void>> registerCustomerWithEmail({String email, String password,
    String firstName, String lastName, String phoneNumber, String referralCode});

  Future<Result<void>> signInWithGoogle();
  Future<void> signOutGoogle();
  Future<Result<void>> getCurrentUser();
  Future<void> addDataToDb(UserData currentUser);
  Future<bool> authenticateUser({User user, String email});
}

class FirebaseViewModel extends ABSFirebaseViewModel {
  ABSFirebaseService _identityService = locator<ABSFirebaseService>();
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();

  @override
  set user(UserData value) {
    _user = value;
    _localStorage.saveUserState(user);
    notifyListeners();
  }

  FirebaseViewModel() {
    _user = _localStorage.getUser();
  }

  @override
  Future<bool> authenticateUser({User user, String email}) async {
    print("Authenticate email is $email");
    bool result = await _identityService.authenticateUser(user: user, email: email);
    return result;
  }

  @override
  Future<Result<void>> loginCustomerWithEmail(
      {String email, String password}) async {
    var result = await _identityService.loginCustomerWithEmail(email: email, password: password);

    if (result.error == false) {
      // * Save login state *
      _localStorage.saveSecondaryState(
          SecondaryState(
              isLoggedIn: true,
              password: password,
              email: email,
              biometricsEnabled: _localStorage.getSecondaryState().biometricsEnabled));

      // * Save user data to local database *
      this.user = result.data;

      // globalAuth = user.token;
    }
    return result;
  }

  @override
  Future<Result<void>> registerCustomerWithEmail(
      {String email, String password, String firstName, String lastName, String phoneNumber, String referralCode}) async {
    var result = await _identityService.registerCustomerWithEmail(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        referralCode: referralCode
    );

    return result;
  }

  @override
  Future<Result<void>> signInWithGoogle() async {
    var result = await _identityService.signInWithGoogle();
    return result;
  }

  @override
  Future<void> signOutGoogle() async {
    await _identityService.signOutGoogle();
  }

  @override
  Future<Result<void>> getCurrentUser() async {
    var result = await _identityService.getCurrentUser();
    return result;
  }

  @override
  Future<void> addDataToDb(UserData currentUser) async {
    var result = await _identityService.addDataToDb(currentUser);
    return result;
  }
}
