import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:koloplan/data/models/individual/user_data.dart';
import 'package:koloplan/data/models/result.dart';

abstract class ABSFirebaseService {
  Future<Result<UserData>> loginCustomerWithEmail({String email, String password});

  Future<Result<void>> registerCustomerWithEmail({String email, String password,
    String firstName, String lastName, String phoneNumber, String referralCode});

  Future<Result<User>> signInWithGoogle();
  Future<void> signOutGoogle();
  Future<Result<UserData>> getCurrentUser();
  Future<void> addDataToDb(UserData currentUser);
  Future<bool> authenticateUser({User user, String email});
}

class FirebaseService extends ABSFirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  UserData userModelObject = UserData();

  String name;
  String email;
  String imageUrl;

  Future<Result<User>> signInWithGoogle() async {
    Result<User> result = Result(error: false);
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    result.data = user;


    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;

    // Only taking the first part of the name, i.e., First Name
    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    if (user != null) {
      this.authenticateUser(user: user).then((isNewUser) {
        if (isNewUser) {
          this.addDataToDb(UserData(
              email: user.email,
              firstName: name,
              lastName: name,
              profilePhoto: user.photoURL,
              userType: "buyer",
              uid: user.uid,
            referralCode: "",
              phoneNumber: ""
          ));
        } else {
          print("user exists");
        }
      });
    } else {
      print("There was an error");
    }
    return result;
  }

  @override
  Future<Result<UserData>> loginCustomerWithEmail({String email, String password}) async {
    Result<UserData> result = Result(error: false);
    try{
      print("User mail is $email");
      print("User password is $password");
      final UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("User uid is ${user.user.uid}");
      var userDocument = await _db.doc('users/${user.user.uid}').get();
      print("User document is $userDocument");
      print("User document data is ${userDocument.data()}");
      result.data = UserData.fromMap(userDocument.data());
      result.message = "Login successful";
      print("Converted user document is ${result.data}");
      result.error = false;
      return result;
    } catch(e) {
      result.error = true;
      result.errorMessage = e.message;
      print("Login Error ${e.message}");
      return result;
    }
  }

  Future<bool> authenticateUser({User user, String email}) async {
    print("Authenticate email service is $email");
    if(user == null) {
      QuerySnapshot result = await _db
          .collection("users")
          .where("email", isEqualTo: email)
          .get();
      final List<DocumentSnapshot> docs = result.docs;
      //if user is registered then length of list > 0 or else less than 0
      return docs.length == 0 ? true : false;
    } else {
      QuerySnapshot result = await _db
          .collection("users")
          .where("email", isEqualTo: user.email ?? email)
          .get();
      final List<DocumentSnapshot> docs = result.docs;
      //if user is registered then length of list > 0 or else less than 0
      return docs.length == 0 ? true : false;
    }
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Sign Out");
  }

  Future<Result<UserData>> getCurrentUser() async {
    Result<UserData> result = Result(error: false);
    User currentUser;
    currentUser = _auth.currentUser;
    print("Current user is $currentUser");

    name = currentUser.displayName;
    var firstName = "";
    var lastName = "";

    // Only taking the first part of the name, i.e., First Name
    if (name.contains(" ")) {
      firstName = name.substring(0, name.indexOf(" "));
      lastName = name.substring(1, name.indexOf(" "));
    }
    result.data = UserData(
      email: currentUser.email,
      firstName: name.contains(" ") ? firstName : name,
      lastName: name.contains(" ") ? lastName : name,
      uid: currentUser.uid,
      profilePhoto: currentUser.photoURL,
    );
    return result;
  }

  Future<void> addDataToDb(UserData currentUser) async {
    // String username = AppUtils.getUsername(currentUser.email);

    userModelObject = UserData(
        uid: currentUser.uid,
        email: currentUser.email,
        firstName: currentUser.firstName,
        lastName: currentUser.lastName,
        profilePhoto: currentUser.profilePhoto,
        referralCode: currentUser.referralCode,
        userType: currentUser.userType,
        phoneNumber: ""
    );

    _db
        .collection("users")
        .doc(currentUser.uid)
        .set(userModelObject.toMap(userModelObject));
  }

  @override
  Future<Result<void>> registerCustomerWithEmail({String email, String password,
    String firstName, String lastName, String phoneNumber, String referralCode}) async {
    Result<void> result = Result(error: false);

      try{
        UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        final User userRemote = user.user;

        print("Register user is $userRemote");

        // Checking if email and name is null
        assert(userRemote.email != null);

        this.authenticateUser(user: userRemote).then((isNewUser) {
          if (isNewUser) {
            // user.user.sendEmailVerification();
            this.addDataToDb(UserData(
              email: userRemote.email,
              firstName: firstName,
              lastName: lastName,
              profilePhoto: userRemote.photoURL,
              userType: "buyer",
              uid: userRemote.uid,
              referralCode: referralCode,
              phoneNumber: phoneNumber
            ));
            result.message = "Your account was created successfully";
            result.error = false;
          } else {
            result.errorMessage = "An account with this email exist";
            result.error = true;
          }
        });
        return result;
      } on SocketException catch (e) {
        result.networkAvailable = false;
        result.error = true;
        result.errorMessage = "Network Error! ${e.message}";
        return result;
      } on FormatException catch (_) {
        result.error = true;
        result.errorMessage = "Sorry, we are unable to complete your request at the moment. Please try again later";
        return result;
      }
      catch(e) {
        print("Error ${e.message}");
        result.error = true;
        result.errorMessage = e.message;
        return result;
      }
  }
}