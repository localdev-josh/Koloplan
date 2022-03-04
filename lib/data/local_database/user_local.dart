import 'package:hive/hive.dart';
import 'package:koloplan/data/models/individual/secondary_state.dart';
import 'package:koloplan/data/models/individual/user_data.dart';
import 'package:koloplan/utils/strings.dart';

abstract class ABSStateLocalStorage {

  void initBox();

  void saveSecondaryState(SecondaryState secondaryState);

  void saveUserState(UserData user);

  SecondaryState getSecondaryState();

  UserData getUser();
}

class StateBoxStorage extends ABSStateLocalStorage{
  Box box;
  @override
  void initBox() {
    box = Hive.box(AppStrings.state);
  }

  StateBoxStorage(){
    initBox();
  }

  @override
  void saveUserState(UserData user) {
    box.put('user', user);
  }

  @override
  void saveSecondaryState(SecondaryState secondaryState) {
    box.put('state', secondaryState);
  }

  @override
  UserData getUser() {
    return box.get('user', defaultValue: null);
  }

  @override
  SecondaryState getSecondaryState() {


    return box.get('state', defaultValue: SecondaryState(isLoggedIn: false));
  }



}