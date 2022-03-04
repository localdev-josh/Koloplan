import 'package:hive/hive.dart';

part 'secondary_state.g.dart';

@HiveType(typeId: 1)
class SecondaryState extends HiveObject{

  @HiveField(0)
  bool isLoggedIn;

  @HiveField(1)
  DateTime lastMinimized;

  @HiveField(2)
  String password;

  @HiveField(3)
  String email;

  @HiveField(4)
  bool biometricsEnabled;

  SecondaryState({this.isLoggedIn = false, this.lastMinimized, this.password,
    this.email,
    this.biometricsEnabled = false});

  static SecondaryState updateBiometrics(bool value, SecondaryState state){
    SecondaryState s = state;
    s.biometricsEnabled = value;
    return s;
  }
}